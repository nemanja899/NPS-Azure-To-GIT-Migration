Import-Module -Name "$Env:BUILD_SOURCESDIRECTORY\nps-build-scripts\HandleDependency.psm1" -Force -DisableNameChecking

# List of the dependency apps required by the PTE app.
# Handle-Dependency -dependencyAppName 'Localization features (Serbia)'