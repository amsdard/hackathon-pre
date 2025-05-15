# 🚀 PRe Hackathon
A ready-to-code Python environment for hackathons with everything you need to start building immediately.

## Getting Ready

### Environment Setup

For the best hackathon experience, we recommend taking a a moment to read the [Detailed Setup Guide](docs/detailed-setup.md). This guide will help you ensure your development environment is properly configured and ready to go.

1. Clone this repository
2. Open in VS Code
3. Click "Reopen in Container" when prompted (or run `Remote-Containers: Reopen in Container` from command palette)
4. Start coding! Create `.py` files or `.ipynb` notebooks and get building


#### Jupyter Notebooks

To create and run Jupyter notebooks:

1. Create a new file with the `.ipynb` extension
2. VS Code will automatically open it with the Jupyter notebook interface
3. Run cells using the play button or `Shift+Enter`


## 🏆 Team Directories

Each team can find their project directory and README below:

- [Team A: AI Powered Scenario Analysis](hackathon/TeamA_AI_Powered_Scenario_Analysis/README.md)
- [Team B: Bill of Material Estimation](hackathon/TeamB_Bill_of_Material_Estimation/README.md)
- [Team C: Data Import/Export/Transformation](hackathon/TeamC_Data_Import_Export_Transformation/README.md)
- [Team D: AI-Assisted Data Mapping](hackathon/TeamD_AI_Assisted_Data_Mapping/README.md)


## Project Structure

- `.devcontainer/` - Docker and VS Code configuration files
  - `Dockerfile` - Base Docker configuration for all teams
  - `TeamA/`, `TeamB/`, `TeamC/`, `TeamD/` - Team-specific container configurations
- `hackathon/` - Team-specific project directories. Each team folder contains README.md file with introduction for your project.
  - `TeamA_AI_Powered_Scenario_Analysis/`
  - `TeamB_Bill_of_Material_Estimation/`
  - `TeamC_Data_Import_Export_Transformation/`
  - `TeamD_AI_Assisted_Data_Mapping/`
- `docs/` - Documentation and setup guides
  - `assets/` - Screenshots and images for documentation

  
Happy coding!