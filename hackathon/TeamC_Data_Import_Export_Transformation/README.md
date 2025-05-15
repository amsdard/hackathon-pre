# Data Import, Export, and Transformation for LCA

## Project Overview

Life Cycle Assessment (LCA) workflows often require complex data exchanges between different systems and tools. This project addresses the challenges of transforming sustainability data between various formats and structures, with a focus on improving interoperability between LCA tools, standards, and reporting frameworks.

**Key Challenge**: LCA datasets are highly complex with nested structures, detailed metadata, and varied unit specifications. Manual reformatting is time-consuming and error-prone, while inconsistencies between different data standards create significant barriers to efficient sustainability assessment.

## Project Goals

This project aims to create a set of instructions for AI tools (Cline/Cursor) to develop a transformation engine. The engine will take input files (like BoM_example1.xlsx or BoM_example2.json) and convert them to specified output formats (like SimaProCSV, ILCD, or ecoSpold2).

The focus is on minimal manual coding - you'll create instructions for the AI tool, which will then generate the necessary transformation code. 

**Note:** When new data format will occur, the python script is no expect to work as it is. On the other hand, your rules should let AI tool to automatically improve the code to work with new schema or extension. 


## Workflow

1. **Create an instructions file** (`clinerules` or `cursorrules`) that directs the AI tool to:
   - Analyze and understand the input data format and structure
   - Analyze and understand the target output format and structure
   - Implement scripts that transform between these formats
   - Take advantage of Plan and Act modes (https://docs.cline.bot/exploring-clines-tools/plan-and-act-modes-a-guide-to-effective-ai-development)

2. **Expected deliverables**:
   - A `clinerules` or `cursorrules` file with clear task descriptions
   - Generated transformation scripts for converting input files to all available output formats
   - Generated output files saved in the `data/outputs/` directory

3. **Development approach**:
   - Start by creating the rules file with general task description and instructions
   - Avoid providing specific technical details (like file extensions) in your rules
   - Instead, instruct the AI to discover these details by examining the files
   - Use the `data/output_description/` directory as a reference for output formats

4. **Testing and iteration**:
   - Test your solution using Cline or Cursor to transform an input file
   - Evaluate the generated code and output files
   - Refine your rules file as needed based on results

**Note**: You may encounter issues with the AI tool reading xlsx files. This is expected, and the AI should be able to solve this problem on its own as part of the exercise.

## Data

### Input Data

Two Bill of Materials files are provided:
- Excel format (xlsx) file
- JSON format file

Both files are located in the `data/inputs/` directory.

### Output Formats

The transformation engine should support conversion to:
- SimaProCSV
- ecoSpold
- ILCD (xml)

Description of each format and example outputs can be found in the `data/output_description/` directory. Note that these examples may not match the input files exactly.
