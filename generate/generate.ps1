# Generate using the templates and config files into the target folder.
$RepoRoot = Split-Path -parent $PSScriptRoot
# Create the path to the XGenerate jar file.
$XGenJar = Join-Path $RepoRoot "lib" "CrossBreeze.CrossGenerate" "XGenerate.jar"
# Create the java execution command.
$XgGenCmd = "java -jar $XGenJar"
# Set the target folder.
$TargetFolder = Join-Path $RepoRoot "target"
$TargetLogFile = Join-Path $TargetFolder "generate.log"

# Remove the target folder if it exists.
if (Test-Path $TargetFolder) {
    Write-Host "[$(Get-Date -format 'yyyy-MM-dd HH:mm:ss')] [INFO] Removing existing target directory"
    Remove-Item $TargetFolder -Recurse -Force
}
# Create the target folder.
$TargetDirectoryObj = New-Item -Path $TargetFolder -ItemType "directory"
Write-Host "[$(Get-Date -format 'yyyy-MM-dd HH:mm:ss')] [INFO] Created target directory"

# Run the generation process.
Write-Host "[$(Get-Date -format 'yyyy-MM-dd HH:mm:ss')] [INFO] Starting CrossGenerate"
# -cll: Console log level
# -fll: File log level
# -fld: File log destionation
# -c: CrossGenerate Application config location.
# -mtc: The Model::Template::Config combinations to generate for.
cmd /c $XgGenCmd `
    -cll WARNING `
    -fll INFO `
    -fld $TargetLogFile `
    -c .\XGenAppConfig.xml `
    -mtc "MDDE_Example/MDDE_Example.xml::Database/Pipeline/PipelineCopyData_Table_Code.json::PipelineADFXmlConfig.xml" `
    -mtc "MDDE_Example/MDDE_Example.xml::Database/Database_Code/Database_Code.sqlproj::DatabaseXmlConfig.xml" `
    -mtc "MDDE_Example/MDDE_Example.xml::Database/Database_Code/Schema_Code/Schema_Code.sql::SchemaTextConfig.xml" `
    -mtc "MDDE_Example/MDDE_Example.xml::Database/Database_Code/Schema_Code/Tables/Table_Code.sql::TableTextConfig.xml" `
    -mtc "MDDE_Example/MDDE_Example.xml::Database/Staging_Database_Code/Staging_Database_Code.sqlproj::DatabaseXmlConfig.xml" `
    -mtc "MDDE_Example/MDDE_Example.xml::Database/Staging_Database_Code/Schema_Code/Staging_Schema_Code.sql::SchemaTextConfig.xml" `
    -mtc "MDDE_Example/MDDE_Example.xml::Database/Staging_Database_Code/Schema_Code/Tables/Table_Code.sql::TableTextConfig.xml" `
    -mtc "MDDE_Example/MDDE_Example.xml::Database/Database_Code.sln::SolutionTextConfig.xml"
    # TODO: The generation of the Database XML file is disabled for now, since there is an issue with namespaces.
    #-mtc "MDDE_Example/MDDE_Example.ldm::Model-Code/Model-Code.database.xml::ModelXmlConfig.xml" 

# Check whether the generation ended with an error.
if ($LASTEXITCODE -eq 1) {
    Write-Error "[$(Get-Date -format 'yyyy-MM-dd HH:mm:ss')] [ERROR] An error occured while generating, please check the log for more details."
    exit
}

Write-Host "[$(Get-Date -format 'yyyy-MM-dd HH:mm:ss')] [INFO] Done"