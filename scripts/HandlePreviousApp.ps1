Import-Module -Name "$Env:BUILD_SOURCESDIRECTORY\nps-build-scripts\HandlePreviousApp.psm1" -Force -DisableNameChecking

# Set previous app name that need to be upgraded to current version
# Handle-PreviousApp -previousAppName 'Loomis API'