# AI-Powered LCA Data Mapping

## Project Overview
Life Cycle Assessment (LCA) models combine detailed, product-specific data (foreground) with standardized environmental data (background) from libraries such as ecoinvent. Linking these two layers requires careful data mapping - a process that is typically done manually, is time-consuming, and requires domain expertise.

**Key Challenge:** Mapping customer-specific materials and activities to appropriate entries in sustainability databases is labor-intensive and prone to inconsistency. Our AI-powered solution aims to automate this process, improving accuracy and significantly reducing the time required for LCA model creation.


## Project Goals

1) Develop an intelligent mapping engine that accurately connects foreground data (customer materials/activities) to background data (standardized environmental datasets)
2) Leverage AI techniques including prompt engineering and semantic search to enhance mapping accuracy
3) Create a flexible system that considers location constraints and applies domain knowledge to select the most appropriate matches

## Technical Approach

Our solution employs a two-step AI-powered process:

### 1. Initial LLM-Based Transformation

**Input:** Customer-specific materials/activities from Bill of Materials (BoM) - `data/BoM_data.csv`,

**Process:** Prompt engineering to direct LLM in transforming generic product names into standardized ecoinvent-related materials/activities,

**Output:** Structured suggestions containing candidate product/activity names and their descriptions.

*Example:* 
- input: O-ring (customer input)
- prompt: "Determine ecoinvent products for O-Ring. Returns only product names"
- output: Seal Production, Natural Rubber Based, Market for Seal, Natural Rubber Based and Synthetic Rubber Production

### 2. Semantic Search Verification

If exact matches aren't found, semantic search identifies similar entries based on description and naming patterns

**Input:** 
- LLM-suggested matches from Step 1,
- fragment of encoinvent query database (`/data/ecoinvent_data.csv`) 

**Process:** Vector-based semantic search against the background database to find closest matches,

**Output:** Top 3 candidates of potential matches from the standardized database, randked by similarity scores.


### Location Handling
The system implements specific rules for location-based matching:

- If supplier location is specified in the foreground data, the engine prioritizes datasets from that exact location
- If no location is specified, the engine defaults to returning only global or Europe datasets
- When multiple location options exist, the engine ranks them by relevance


## Example Mappings

- Brushed Aluminum (no location) → Market for Aluminum (global) - When no location is specified, the system defaults to global datasets
- recycled PET granulate bottle (Canada) → polyethylene terephthalate, granulate, bottle grade, recycled, (Canada, Québec (CA-QC)) - Location information enables more precise regional matching
- Aluminum component for e-bike → aluminium alloy, AlMg3 (chosen over aluminium alloy, AlLi) - Context of application (e-bike production) informs the selection of the appropriate alloy type

## Getting starting

### 1. Start with LLM Integration (Warmup Notebook 1):

- Open notebooks/LLM_data_generation.ipynb to learn the fundamentals of LLM interaction
- Understand how to craft effective prompts for material transformation
- Practice generating structured responses using the LLM API
- Implement your own prompt templates for ecoinvent product matching


### 2. Explore Semantic Search (Warmup Notebook 2):

- Work through notebooks/semantic_search_and_vectorstores.ipynb
- Learn about text embeddings and similarity-based search
- Understand vector database setup and query optimization
- Setup your pinecone vectorstore with ecoinvent query data (`data/ecoinvent_data.csv`). Use product name and description as document text and location as metadata. When querying, start with filtering geography 
- Practice implementing semantic search for material matching
