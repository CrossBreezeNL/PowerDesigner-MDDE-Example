# Library

This folder contains dependencies for this repository. These dependencies are:

- [CrossGenerate](./CrossBreeze.CrossGenerate/)
- [PowerDeComposer](./CrossBreeze.PowerDeComposer/)

## Update a dependency

The command to download/update a package is listed below.

```powershell
Install-Package CrossBreeze.<Package> -Destination <Git-Root>/lib
```

For updating CrossGenerate it would be as follows:

```powershell
Install-Package CrossBreeze.CrossGenerate -Destination <Git-Root>/lib
```

> Make sure to remove the version number from the folder name after updating. This way we can make sure the references files are always in the same location.