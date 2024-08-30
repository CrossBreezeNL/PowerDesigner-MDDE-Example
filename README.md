# PowerDesigner-MDDE-Example

This repository contains an example of a model driven data engineering (MDDE) project using [SAP PowerDesigner](https://www.sap.com/products/technology-platform/powerdesigner-data-modeling-tools.html), the [MDDE Extension](https://github.com/CrossBreezeNL/PowerDesigner-MDDE-Extension), [PowerDeComposer](https://powerdecomposer.crossbreeze.nl/), [CrossGenerate](https://generate.crossbreeze.nl/) &amp; [CrossTest](https://test.crossbreeze.nl/)

Model driven data engineering (MDDE) is an approach to apply model driven development metholody in a data engineering world. In this example the logical modeling is done in SAP PowerDesigner, version control is done in Git with PowerDeComposser, code generation is done with CrossGenerate and SpecFlow with CrossTest is used as the test framework.

Within MDDE the idea is to model as much as possible and generate the (majority of the) end-solution without manual intervention. In this example the logical data model contains all metadata needed to generate the solution and the generate, deploy & test phases are all automated in the GitHub workflow.

## Modeling

The PowerDesigner model files can be found in the [model](./model) folder. In this example we are using PowerDeComposer to make version management of the PowerDesigner files in a file-based version control system (like Git) a lot easier. With PowerDeComposer the PowerDesigner mode files are decomposed into separate files. Each entity within a PowerDesigner logical data model will end up in it's own file, i.s.o. all in one file. The decomposed files are stored in this repository in the [model/decomposed](./model/decomposed) folder.

### PowerDesigner named paths

Create the following named paths in PowerDesigner (via Tools -> General Options... -> Named Paths). In the Path the {Git-Folder} part should be replaced with the folder reference relative to the root of this repository on your machine. For the [XEM] config, only add the path, don't remove existing entries.

| Name                 | Path                                                       |
|----------------------|------------------------------------------------------------|
| MDDE_EXAMPLE_MODELS  | {Git-Folder}\models\composed\                              |
| PDC_SCRIPT_PATH      | {Git-Folder}\lib\CrossBreeze.PowerDeComposer\              |
| [XEM]                | {Git-Folder}\lib\CrossBreeze.PowerDesigner-MDDE-Extension\ |

### Start modeling

To start modeling you need to first compose all decomposed models. After composing the models to use from within PowerDesigner can be found in the [models/composed](./models/composed) folder. The compose you need to execute the following command:

```powershell
models/compose_all.ps1
```

After composing you can open the Workspace.sws file in the composed folder to start modelling.

The manual for modelling with the MDDE extension in PowerDesigner can be found [here](https://github.com/CrossBreezeNL/PowerDesigner-MDDE-Extension/blob/main/manual/README.md).

### Commit changes

When you are done modeling, the changes can be effectuated into Git by decomposing the PowerDesigner model with PowerDeComposer. This is integrated into PowerDesigner and instruction on how to perform this can be found [here](https://github.com/CrossBreezeNL/PowerDesigner-MDDE-Extension/blob/main/manual/PowerDeComposer.md).

After decomposing the changes in the decomposed folder can be committed and pushed into Git to trigger the workflow for buid, deploy and test.
