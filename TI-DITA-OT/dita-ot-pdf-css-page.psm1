set-strictmode -version 2.0

function RunAnt_PdfCssPage
{
	param
	(
		[String]$MapFileLocation,
		[String]$OutputFolder,
		[String]$TempFolder,
		[String]$LogFileLocation,
		[String]$DITAOTTransType, # e.g. ishditadelivery
		[String]$DraftComments, # yes/no
		[String]$Compare, # yes/no
		[String]$CombinedLanguages, # yes/no
		[String]$PublishPostProcessContextFileLocation
	)

	Write-Host "Running RunAnt_PdfCssPage..."

	# If "Compare<>yes" set validate to "yes" as the input files for DITA-OT should contain valid DITA xml
	$Dvalidate = "yes"
	If ($Compare -eq "yes")
	{
		# If "Compare=yes" set validate to "no" as the input files for DITA-OT contains the comparison result and may not be valid DITA anymore
		$Dvalidate = "no"
	}

	[xml]$xmlContextFile = Get-Content -Path $PublishPostProcessContextFileLocation
	$Languages = $xmlContextFile.SelectSingleNode("/publishpostprocesscontext/languages").InnerText
	
	$command = "ant.bat -Dhtml.pdf.formatter=antennahouse -Dhtml.pdf.formatter.path=""C:\Program Files\Antenna House\AHFormatterV65\AHFCmd.exe"" -Dtranstype=""$DITAOTTransType"" -Dargs.input=""$MapFileLocation"" -Doutput.dir=""$OutputFolder"" -Ddita.temp.dir=""$TempFolder"" -Dargs.draft=""$DraftComments"" -Dclean.temp=no -Dvalidate=$Dvalidate -Dargs.language=""$Languages"" -logfile ""$LogFileLocation"""
	Write-Host "Running command ""$command"""
	& ant.bat "-Dhtml.pdf.formatter=antennahouse" "-Dhtml.pdf.formatter.path=""C:\Program Files\Antenna House\AHFormatterV65\AHFCmd.exe""" "-Dtranstype=$DITAOTTransType" "-Dargs.input=""$MapFileLocation""" "-Doutput.dir=""$OutputFolder""" "-Ddita.temp.dir=""$TempFolder""" "-Dargs.draft=$DraftComments" "-Dclean.temp=no" "-Dvalidate=$Dvalidate" "-Dargs.language=""$Languages""" -logfile "$LogFileLocation"
}
