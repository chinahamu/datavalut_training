import glob
import os
import pandas as pd
import re

# Set the input and output folder names
input_folder = 'AdventureWorks/tmp'
output_folder = 'AdventureWorks/seeds'

# Get a list of all CSV files in the input folder
csv_files = glob.glob(os.path.join(input_folder, '*.csv'))

# Iterate over the CSV files
for csv_file in csv_files:
    # Read the CSV file into a pandas DataFrame
    df = pd.read_csv(csv_file)

    # Convert the column names to snake_case
    df.columns = [re.sub(r'(?<=[a-z0-9])(?=[A-Z])', '_', col).lower() for col in df.columns]

    # Get the base name of the CSV file (without the .csv extension)
    base_name = os.path.splitext(os.path.basename(csv_file))[0]

    # Convert the base name to snake_case
    snake_name = re.sub(r'(?<=[a-z0-9])(?=[A-Z])', '_', base_name).lower()

    # Build the path of the new CSV file in the output folder with the modified name
    new_path = os.path.join(output_folder, snake_name + '.csv')

    # Write the modified DataFrame to the new CSV file
    df.to_csv(new_path, index=False)
