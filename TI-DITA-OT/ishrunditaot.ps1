# ishrunditaot.cmd is called from the IshRunDITAOT publishpostprocess plugin

#
# READING SCRIPT ARGUMENTS
#  
param
(
	[Parameter(Position=0)]
	$MapFileLocation,
	[Parameter(Position=1)]
	$OutputFolder,
	[Parameter(Position=2)]
	$TempFolder,
	[Parameter(Position=3)]
	$LogFileLocation,
	[Parameter(Position=4)]
	$DITAOTTransType, # e.g. ishditadelivery
	[Parameter(Position=5)]
	$DraftComments, # yes/no
	[Parameter(Position=6)]
	$Compare, # yes/no
	[Parameter(Position=7)]
	$CombinedLanguages, # yes/no
	[Parameter(Position=8)]
	$PublishPostProcessContextFileLocation
)

Write-Host "*********************************"
Write-Host "ISHRUNDITAOT.ps1"
Write-Host "*********************************"

$DebugPreference   = "SilentlyContinue"   # Continue or SilentlyContinue
$VerbosePreference = "SilentlyContinue"   # Continue or SilentlyContinue
$WarningPreference = "Continue"           # Continue or SilentlyContinue or Stop
$ProgressPreference= "SilentlyContinue"   # Continue or SilentlyContinue
$ErrorActionPreference = "Stop"           # Treat all errors as terminating errors

#
# LOAD MODULES
#
Write-Host "Loading Modules..."	
Import-Module ./config.psm1
# Custom modules
Import-Module ./config.custom.psm1
Import-Module ./dita-ot-ishhtmlhelp.psm1
Import-Module ./dita-ot-pdf-css-page.psm1

if ($DITAOTTransType -eq "ishhtmlhelp")
{
	RunAnt_IshHtmlHelp $MapFileLocation $OutputFolder $TempFolder $LogFileLocation $DITAOTTransType $DraftComments $Compare $CombinedLanguages $PublishPostProcessContextFileLocation
}
elseif ($DITAOTTransType -eq "pdf-css-page" -or $DITAOTTransType -eq "ti-css-pdf")
{
	RunAnt_PdfCssPage $MapFileLocation $OutputFolder $TempFolder $LogFileLocation $DITAOTTransType $DraftComments $Compare $CombinedLanguages $PublishPostProcessContextFileLocation
}
else
{
	# If "Compare<>yes" set validate to "yes" as the input files for DITA-OT should contain valid DITA xml
	$Dvalidate = "yes"
	If ($Compare -eq "yes")
	{
		# If "Compare=yes" set validate to "no" as the input files for DITA-OT contains the comparison result and may not be valid DITA anymore
		$Dvalidate = "no"
	}

	$command = "ant.bat -Dtranstype=""$DITAOTTransType"" -Dargs.input=""$MapFileLocation"" -Doutput.dir=""$OutputFolder"" -Ddita.temp.dir=""$TempFolder"" -Dargs.draft=""$DraftComments"" -Dclean.temp=no -Dvalidate=$Dvalidate -logfile ""$LogFileLocation"""
	Write-Host "Running command ""$command"""	
	& ant.bat "-Dtranstype=$DITAOTTransType" "-Dargs.input=""$MapFileLocation""" "-Doutput.dir=""$OutputFolder""" "-Ddita.temp.dir=""$TempFolder""" "-Dargs.draft=$DraftComments" "-Dclean.temp=no" "-Dvalidate=$Dvalidate" -logfile "$LogFileLocation"
	$exitCode = $LASTEXITCODE
	Write-Host "ant completed with exit code $exitCode"
	exit $exitCode
}