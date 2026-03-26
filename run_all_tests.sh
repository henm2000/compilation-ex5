#!/bin/bash

set -u

# Define absolute paths based on the script's current location
BASEDIR="$(cd "$(dirname "$0")" && pwd)"
INPUT_DIR="${BASEDIR}/input"
OUTPUT_DIR="${BASEDIR}/output"
EXPECTED_OUTPUT_DIR="${BASEDIR}/expected_output"
TIMEOUT_SECONDS="${TIMEOUT_SECONDS:-20}"

# Initialize counters for summary
TOTAL_TESTS=0
FAILED_TESTS=0
FAILED_TESTS_NAMES=()
TIMED_OUT_TESTS=0
TIMED_OUT_TESTS_NAMES=()

# Step 1: Compile the project
echo "Compiling project..."
make compile

# Step 2: Process each .txt file in the input directory
for INPUT_FILE in ${INPUT_DIR}/*.txt; do
    [[ -e "$INPUT_FILE" ]] || continue

    # Extract the filename without the extension
    FILENAME=$(basename -- "$INPUT_FILE")
    FILENAME_WITHOUT_EXT="${FILENAME%.*}"

    # Define the output and MIPS output filenames
    OUTPUT="${OUTPUT_DIR}/${FILENAME_WITHOUT_EXT}_MIPS.txt"
    MIPS_OUTPUT="${OUTPUT_DIR}/${FILENAME_WITHOUT_EXT}_MIPS_OUTPUT.txt"

    # Run the compiled Java program with the current input and output files
    echo "Processing ${INPUT_FILE}..."
    if ! timeout "${TIMEOUT_SECONDS}s" java -jar ${BASEDIR}/COMPILER "${INPUT_FILE}" "${OUTPUT}"; then
        echo "Compilation stage timed out/failed for ${FILENAME_WITHOUT_EXT}."
        ((FAILED_TESTS++))
        ((TIMED_OUT_TESTS++))
        TIMED_OUT_TESTS_NAMES+=("${FILENAME_WITHOUT_EXT}:compiler")
        continue
    fi

    # Run spim on the output file and redirect its output
    echo "Running spim on ${OUTPUT}..."
    if ! timeout "${TIMEOUT_SECONDS}s" spim -f "${OUTPUT}" > "${MIPS_OUTPUT}"; then
        echo "SPIM stage timed out/failed for ${FILENAME_WITHOUT_EXT}."
        ((FAILED_TESTS++))
        ((TIMED_OUT_TESTS++))
        TIMED_OUT_TESTS_NAMES+=("${FILENAME_WITHOUT_EXT}:spim")
        continue
    fi
done

# New step: Append an empty line to each MIPS_OUTPUT.txt file
echo "Appending an empty line to each MIPS_OUTPUT.txt file..."
for MIPS_OUTPUT_FILE in ${OUTPUT_DIR}/*_MIPS_OUTPUT.txt; do
    echo "" >> "$MIPS_OUTPUT_FILE"
done

# Step 3: Compare output files with expected output
echo "Comparing output files with expected outputs..."
for OUTPUT_FILE in ${OUTPUT_DIR}/*_MIPS_OUTPUT.txt; do
    # Increment total tests counter
    ((TOTAL_TESTS++))

    # Extract the base filename for matching with expected output
    FILENAME=$(basename -- "$OUTPUT_FILE")
    EXPECTED_FILE="${EXPECTED_OUTPUT_DIR}/${FILENAME%_MIPS_OUTPUT.txt}_EXPECTED_OUTPUT.txt"

    # Check if the expected output file exists
    if [[ -f "$EXPECTED_FILE" ]]; then
        # Compare the content of the output and expected output files
        if cmp -s "$OUTPUT_FILE" "$EXPECTED_FILE"; then
            echo "Test ${FILENAME%_MIPS_OUTPUT.txt} passed."
        else
            echo "Test ${FILENAME%_MIPS_OUTPUT.txt} failed."
            ((FAILED_TESTS++))
            FAILED_TESTS_NAMES+=("${FILENAME%_MIPS_OUTPUT.txt}")
        fi
    else
        echo "Expected output for ${FILENAME%_MIPS_OUTPUT.txt} not found."
        ((FAILED_TESTS++))
        FAILED_TESTS_NAMES+=("${FILENAME%_MIPS_OUTPUT.txt}")
    fi
done

# Step 4: Print summary
echo -e "\nSummary:"
echo "Total tests: $TOTAL_TESTS"
echo "Failed tests: $FAILED_TESTS"
echo "Timed out tests: $TIMED_OUT_TESTS"
if [ $FAILED_TESTS -gt 0 ]; then
    echo "Tests that failed: ${FAILED_TESTS_NAMES[*]}"
else
    echo "All tests passed."
fi
if [ $TIMED_OUT_TESTS -gt 0 ]; then
    echo "Tests that timed out: ${TIMED_OUT_TESTS_NAMES[*]}"
fi
