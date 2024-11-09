#!/bin/bash

# Path to the CSV file with model results
csv_file="report/baseline_model_results.csv"
if [[ ! -f "$csv_file" ]]; then
echo "Error: $csv_file not found."
exit 1
fi

# Extract the best model based on F1-score
best_model=$(sort -t, -k5 -rg "$csv_file" | head -n 1)

# Extract individual fields from the best model
data_version=$(echo "$best_model" | awk -F, '{print $1}')
model_name=$(echo "$best_model" | awk -F, '{print $2}')
precision=$(echo "$best_model" | awk -F, '{print $3}')
recall=$(echo "$best_model" | awk -F, '{print $4}')
f1_score=$(echo "$best_model" | awk -F, '{print $5}')
roc_auc=$(echo "$best_model" | awk -F, '{print $6}')

# Construct the confusion matrix image path (adjust as needed)
confusion_matrix="report/${data_version}_${model_name}_confusion_matrix.png"

# Generate the Markdown report
cat << EOF > baseline_model_report.md
## Best Baseline Model

# Model information
* **Data Version:** $data_version
* **Model Name:** $model_name

# Performance Metrics
* **Precision:** $precision
* **Recall:** $recall
* **F1-Score:** $f1_score
* **ROC-AUC:** $roc_auc

*Confusion Matrix:*
[Image of confusion matrix]($confusion_matrix)
EOF
