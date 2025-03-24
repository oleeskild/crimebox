#!/bin/bash

# Script to analyze a local repository for hotspots and visualize them
# Exit on error
set -e

# Determine absolute paths
if [[ $(basename $(pwd)) == "ExampleScripts" ]]; then
    # Running from Examples directory
    ABSOLUTE_ROOT_DIR=$(cd ..; pwd)
else
    # Running from root directory
    ABSOLUTE_ROOT_DIR=$(pwd)
fi

# Variables
REPO_PATH="/code"
REPO_NAME="FjordTours.Availability2"
ANALYSIS_DIR="$ABSOLUTE_ROOT_DIR/analysis_results"
REPO_ANALYSIS_DIR="$ANALYSIS_DIR/$REPO_NAME"
MAAT_SCRIPTS_DIR="$ABSOLUTE_ROOT_DIR/maat-scripts"
TRANSFORM_DIR="$MAAT_SCRIPTS_DIR/transform"
MERGE_DIR="$MAAT_SCRIPTS_DIR/merge"

echo "=== Local Repository Hotspot Analysis ==="
echo "This script will:"
echo "1. Use repository from $REPO_PATH"
echo "2. Generate git log for analysis"
echo "3. Run cloc for code metrics"
echo "4. Run code-maat to find hotspots"
echo "5. Merge frequency and complexity data"
echo "6. Generate JSON for visualization"
echo "7. Start HTTP server to view visualization"
echo ""

# Check if repository exists
if [ ! -d "$REPO_PATH" ]; then
    echo "Error: Repository not found at $REPO_PATH"
    echo "Please ensure the repository is mounted at /code"
    exit 1
fi

# Create directories
echo "Creating directories..."
mkdir -p "$REPO_ANALYSIS_DIR"

# Generate git log for analysis
echo "Generating git log..."
cd "$REPO_PATH/$REPO_NAME"
git log --all --numstat --date=short --pretty=format:'--%h--%ad--%aN' --no-renames --after=2024-01-01 > "$REPO_ANALYSIS_DIR/git_log.txt"

# Run cloc for language statistics from inside the repository
echo "Running cloc analysis..."
# Run cloc from within the repository to get correct relative paths
cloc . --by-file --csv --exclude-dir=bin,obj --out="$REPO_ANALYSIS_DIR/complexity.csv"

# Return to the root directory
cd "$ABSOLUTE_ROOT_DIR"

# Run code-maat hotspot analysis
echo "Running code-maat hotspot analysis..."
code-maat -l "$REPO_ANALYSIS_DIR/git_log.txt" -c git2 -a revisions > "$REPO_ANALYSIS_DIR/revisions.csv"

# Merge revisions and complexity data
echo "Merging frequency and complexity data..."
# Use absolute paths to avoid navigation issues
python3 "$MERGE_DIR/merge_comp_freqs.py" "$REPO_ANALYSIS_DIR/revisions.csv" "$REPO_ANALYSIS_DIR/complexity.csv" > "$REPO_ANALYSIS_DIR/hotspots.csv"

echo "Converting analysis results to JSON for visualization..."
python3 "$MAAT_SCRIPTS_DIR/transform/csv_as_enclosure_json.py" \
    --structure "$REPO_ANALYSIS_DIR/complexity.csv" \
    --weights "$REPO_ANALYSIS_DIR/hotspots.csv" \
    > "$REPO_ANALYSIS_DIR/hotspots.json"

# Copy the visualization files to the analysis directory
echo "Copying visualization files..."
cp "$TRANSFORM_DIR/crime-scene-hotspots.html" "$REPO_ANALYSIS_DIR/"
cp -r "$TRANSFORM_DIR/d3" "$REPO_ANALYSIS_DIR/"

echo "Analysis complete!"
echo "Analysis results stored in: $REPO_ANALYSIS_DIR"
echo "Hotspots CSV: $REPO_ANALYSIS_DIR/hotspots.csv"
echo "Hotspots JSON: $REPO_ANALYSIS_DIR/hotspots.json"

# Start HTTP server in the analysis directory
echo "Starting HTTP server for visualization..."
echo "Open your browser at http://localhost:8000/crime-scene-hotspots.html"
cd "$REPO_ANALYSIS_DIR"
python3 -m http.server 8000 