
# UK General Election 2019 Analysis

This project estimates the 2019 UK General Election results using a Multilevel Regression and Poststratification (MRP) model. It aims to uncover voting patterns across demographic groups in England and Wales, employing data from the British Election Study and population counts from the Office for National Statistics (ONS).

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Project Structure

- **01_code**: Contains a single, comprehensive Python Jupyter notebook that includes data preprocessing, the MRP model implementation, result scaling, and visualisation.
- **02_data**: This directory stores the raw data files, including population counts for demographic groups and election study data, used in the analysis.
- **03_research+codebooks**: Provides documentation on the data sources, variable descriptions, and any codebooks or metadata relevant to understanding the data and analysis processes.
- **04_graphs**: Generated graphs from the analysis are stored here, showcasing demographic voting patterns, constituency-level estimates vs. actual results, and other exploratory or result-focused visuals.
- **05_output**: Contains the output from the analysis, including model-generated CSV files and Stan model files.

## Getting Started

To replicate the analysis or explore the data:

1. Clone this repository to your local machine.
2. Ensure Python 3.11.8 is installed along with the required libraries, such as pandas, numpy, matplotlib, and scipy. Use `pip install` to install any missing libraries.
3. Open the Jupyter notebook located in the `01_code` directory. The notebook is fully documented, guiding you through each step of the analysis from data loading to visualisation.

## Data Sources

- Demographic group and population count data were sourced from the ONS "Create a custom dataset" page.
- Insights into voting patterns and demographics were derived using publicly available data from the British Election Study.

## Acknowledgments

- British Election Study for providing accessible and comprehensive election data.
- Office for National Statistics for supplying detailed demographic and constituency-level population data.
