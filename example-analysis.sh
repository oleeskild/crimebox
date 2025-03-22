#!/bin/bash

# Example script demonstrating how to use code-maat and cloc for repository analysis
# This is just a template - customize for your specific needs

# Exit on error
set -e

# Variables
REPO_URL=${1:-https://github.com/torvalds/linux.git}
REPO_NAME=$(basename $REPO_URL .git)
ANALYSIS_DIR="analysis_results"

# Create directories
mkdir -p $ANALYSIS_DIR
mkdir -p repos

# Clone repository if not exists
if [ ! -d "repos/$REPO_NAME" ]; then
    echo "Cloning $REPO_URL..."
    git clone --depth=1 $REPO_URL repos/$REPO_NAME
fi

cd repos/$REPO_NAME

# Generate git log for analysis
echo "Generating git log..."
git log --all --numstat --date=short --pretty=format:'--%h--%ad--%an' > ../../$ANALYSIS_DIR/git_log.txt

cd ../..

# Run cloc for language statistics
echo "Running cloc analysis..."
cloc repos/$REPO_NAME --by-file --csv --out=$ANALYSIS_DIR/cloc_output.csv

# Run code-maat analysis
echo "Running code-maat analysis..."

# Author statistics
echo "Generating author statistics..."
cat $ANALYSIS_DIR/git_log.txt | code-maat -c git2 -a authors > $ANALYSIS_DIR/authors.csv

# Code churn analysis
echo "Generating code churn analysis..."
cat $ANALYSIS_DIR/git_log.txt | code-maat -c git2 -a entity-churn > $ANALYSIS_DIR/entity_churn.csv

# Coupling analysis
echo "Generating coupling analysis..."
cat $ANALYSIS_DIR/git_log.txt | code-maat -c git2 -a coupling > $ANALYSIS_DIR/coupling.csv

echo "Analysis complete. Results are in $ANALYSIS_DIR directory."
echo "You can visualize these results using the scripts from the maat-scripts repository."
echo "Example: cd /workspace/maat-scripts && python3 csv_as_enclosure_json.py ../$ANALYSIS_DIR/authors.csv > authors.json"

# Make the script executable
chmod +x example-analysis.sh 