# Generate using the templates and config files into the target folder.
$RepoRoot = Split-Path -parent $PSScriptRoot
$XGenJar = "$RepoRoot\lib\CrossBreeze.CrossGenerate\XGenerate.jar"
$XgGenCmd = "java -jar $XGenJar"

cmd /c $XgGenCmd -cll INFO -c .\XGenAppConfig.xml `
    -mtc "../models/decomposed/MDDE_Example/MDDE_Example.ldm::Model-Code/Model-Code.database.xml::ModelXmlConfig.xml" `
    -mtc "../models/decomposed/MDDE_Example/MDDE_Example.xml::Database_Code/Pipeline/PipelineCopyData_Table_Code.json::PipelineADFXmlConfig.xml"