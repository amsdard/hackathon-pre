# BoM Enrichment and generation

## Project Overview

This project addresses a critical challenge in Life Cycle Assessment (LCA) models: incomplete or inconsistent Bill of Materials (BoM) data. LCA models require detailed BoM and process data to accurately evaluate environmental impacts, but sustainability datasets frequently suffer from quality issues when combining client-specific input with generic background data. 

This project explores innovative approaches using AI and statistical techniques to:
1. Complete existing datasets through intelligent imputation and detection of outliers
2. Generate realistic synthetic BoMs for prototyping and development for given product (PC, RAM, CPU card and SSD)

By improving data quality and generating representative synthetic data, we enable more accurate sustainability assessments and facilitate development of robust LCA models even when original data is incomplete.

## Data Processing Approach

### EDA and data preprocessing
First, you will start with Exploratory Data Analysis (EDA). It is a process of understanding the data and its quality. You will use `ydata-profiling` library to generate a report and analyze the data. 
The report let you quickly identify:

- Missing values
- Outliers
- Correlations
- Data types
- Distribution
- Unique values

Later, you will proceed with data preprocessing. It includes:

1. **Removal of duplicated records**

2. **Missing Value Imputation**
   - Statistical methods (mean, median, mode) for simple cases
   - Machine learning techniques (MICE) for complex relationships

3. **Anomaly Detection and Treatment**
   - Statistical methods for outlier identification
   - Machine learning models for complex anomaly detection
   - Domain-specific validation rules for BoM data

The result of this step is a cleaned dataset that can be used for further analysis.

### Synthetic Data Generation

The project provides tools to generate realistic synthetic BoM data:
- Modeling of feature distributions
- Preservation of relationships between components
- Generation of realistic numerical values


## LLM-based BoM Creation

The project leverages prompt engineering techniques to create structured BoMs:

1. **Prompt Engineering**
   - Systematic design of prompts for structured output
   - Incorporation of domain knowledge for realistic BoMs
   - Techniques for ensuring completeness and consistency

2. **Model Parameters**
   - Optimization of temperature and other generation parameters
   - Comparison of different model performances

3. **Output Processing**
   - Conversion of LLM responses to structured formats (JSON, CSV)
   - Validation and cleaning of generated content

## Getting Started

1. Start with the **Warmup notebooks** (`notebooks/data_processing.ipynb` and `notebooks/LLM_data_generation.ipynb`) to familiarize yourself with the EDA and data preprocessing steps.
2. Create a new notebook to analyze and process `data/BoM_example.csv` like you do in warmup notebook:
   a) Load data
   b) Generate EDA report
   c) Clean data
   d) Generate synthetic data
   e) List down all observed issues with data
3. Write a Python script or notebook to generate BoM using Claude API. 

Start with a single prompt, where describe the expected schema of BoM file and use product name and description as variables. You can choose Pydantic or Json output parser.

In next step remove output schema from promp and use (Few-shot learning)[https://python.langchain.com/docs/how_to/few_shot_examples/] technique. To do this, load BoM data with pandas, clean it, and save as json. Then provide your prompt with this json example. Thanks to that LLM you must no longer provide LLM with expected schema - it should understand it by reading example.

Spare a time to try different claude models and tune its parameters (temperature, max_tokens, top_k, top_p).
- `max_tokens` - Denotes the number of tokens to predict per generation,
- `temperature` - A non-negative float that tunes the degree of randomness in generation,
- `top_k` - Number of most likely tokens to consider at each step,
- `top_p` - Total probability mass of tokens to consider at each step.


### Expected Outputs
A successful project will deliver:
- Documentation of data quality issues and how they were addressed
- A cleaned and processed version of the BoM dataset
- A synthetic BoM dataset that realistically represents the products: PC, RAM, CPU card and SSD
- An LLM-generated BoM with proper structure and realistic values. Input is product names, output is BoM file


## Data Files
- `BoM_example.csv`: Example Bill of Materials file containing component data. Use a template


## Resources
1. Available Claude models: https://docs.anthropic.com/en/docs/about-claude/models/all-models
