set-strictmode -version 2.0

function PrintAndValidatePath
{
	param
	(
		[String]$key,
		[String]$value
	)
	
	If ($value -eq "")
	{
		Write-Host "$key is empty"
	}
	Else
	{
		If (-not (Test-Path $value))
		{
			Write-Host "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
			Write-Host "*-* Config.psm1::VALUE OF PARAMETER $key IS NOT A FOLDER"
			Write-Host "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
		}
		Write-Host "$key=$value"
	}
}

function PrintAndValidateFilePath
{
	param
	(
		[String]$key,
		[String]$value
	)
	
	If ($value -eq "")
	{
		Write-Host "$key is empty"
	}
	Else
	{
		If (-not (Test-Path $value))
		{
			Write-Host "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
			Write-Host "*-* Config.psm1::VALUE OF PARAMETER $key IS NOT A FILE"
			Write-Host "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
		}
		Write-Host "$key=$value"
	}
}

function PrintParameter
{
	param
	(
		[String]$key,
		[String]$value
	)
	
	If ($value -eq "")
	{
		Write-Host "$key is empty!"
	}
	Else
	{
		Write-Host "$key=$value"
	}
}

Write-Host "Config.psm1::Initialising InstallTool values"
$ENV:PS_BASEPATH="C:\InfoShare\Data\PublishingService"
$ENV:PS_TOOLPATH="C:\InfoShare\App\Utilities\PublishingService\Tools"
$ENV:PS_ERROROBJECTLOCATION="C:\InfoShare\App\Utilities\PublishingService\Resources"
$ENV:PS_DITAOT=(Get-Location).Path
$ENV:PS_UTILITIES="C:\InfoShare\App\Utilities"
$ENV:JAVA_HOME="C:\AdoptOpenJDK\jdk-11+28-jre"
$ENV:JHHOME="C:\javahelp\jh2.0"
$ENV:AXF_DIR="C:\Program Files\Antenna House\AHFormatterV65"
$ENV:AXF_OPT="C:\InfoShare\App\Utilities\AntennaHouse\XSLFormatter\XfoSettings.xml"
# $ENV:XEP_DIR="C:\Program Files\Antenna House\AHFormatterV65"
# $ENV:PE_DIR="C:\Program Files\Antenna House\AHFormatterV65"
$ENV:HHCDIR="C:\Program Files (x86)\HTML Help Workshop"
$ENV:PDF_FORMATTER="ah"

$ENV:ANT_HOME=$ENV:PS_DITAOT
$ENV:PATH="$ENV:JAVA_HOME\bin;$ENV:ANT_HOME\bin;$ENV:PATH"

$ENV:CLASSPATH="$ENV:PS_DITAOT\lib;$ENV:PS_DITAOT\lib\dost.jar;$ENV:PS_DITAOT\lib\resolver.jar;$ENV:PS_DITAOT\lib\icu4j-61.1.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\commons-codec-1.4.jar;$ENV:PS_DITAOT\lib\xercesImpl.jar;$ENV:PS_DITAOT\lib\xml-apis-1.4.01.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\saxon\saxon9.jar;$ENV:PS_DITAOT\lib\saxon\Saxon-HE-9.8.0-14.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\saxon\saxon9.jar;$ENV:PS_DITAOT\lib\saxon\ant.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\saxon\saxon9.jar;$ENV:PS_DITAOT\lib\saxon\ant-apache-resolver-1.10.5.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\saxon\saxon9.jar;$ENV:PS_DITAOT\lib\saxon\ant-launcher.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\saxon\saxon9.jar;$ENV:PS_DITAOT\lib\saxon\commons-io-2.6.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\saxon\saxon9.jar;$ENV:PS_DITAOT\lib\saxon\dost.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\saxon\saxon9.jar;$ENV:PS_DITAOT\lib\dost-configuration.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\saxon\saxon9.jar;$ENV:PS_DITAOT\lib\jackson-annotations-2.9.0.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\saxon\saxon9.jar;$ENV:PS_DITAOT\lib\jackson-core-2.9.8.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\saxon\saxon9.jar;$ENV:PS_DITAOT\lib\jackson-databind-2.9.8.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\saxon\saxon9.jar;$ENV:PS_DITAOT\lib\logback-classic-1.2.3.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\saxon\saxon9.jar;$ENV:PS_DITAOT\lib\logback-core-1.2.3.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\saxon\saxon9.jar;$ENV:PS_DITAOT\lib\slf4j-api-1.7.25.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\saxon\saxon9.jar;$ENV:PS_DITAOT\lib\xercesImpl-2.12.0.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\saxon\saxon9.jar;$ENV:PS_DITAOT\lib\xml-apis-1.4.01.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\lib\saxon\saxon9.jar;$ENV:PS_DITAOT\lib\xml-resolver-1.2.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\plugins\org.dita.pdf2\lib\fo.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\plugins\org.dita.pdf2.axf\lib\axf.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\plugins\org.dita.pdf2.fop\lib\avalon-framework-api-4.3.1.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\plugins\org.dita.pdf2.fop\lib\avalon-framework-impl-4.3.1.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\plugins\org.dita.pdf2.fop\lib\batik-all-1.10.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\plugins\org.dita.pdf2.fop\lib\fontbox-2.0.13.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\plugins\org.dita.pdf2.fop\lib\fop-pdf-images-2.3.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\plugins\org.dita.pdf2.fop\lib\pdfbox-2.0.13.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\plugins\org.dita.pdf2.fop\lib\fop-2.3.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\plugins\org.dita.pdf2.fop\lib\jcl-over-slf4j-1.7.25.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\plugins\org.dita.pdf2.fop\lib\xml-apis-ext-1.3.04.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\plugins\org.dita.pdf2.fop\lib\xmlgraphics-commons-2.3.jar;$ENV:CLASSPATH"
$ENV:CLASSPATH="$ENV:PS_DITAOT\plugins\org.dita.pdf2.xep\lib\xep.jar;$ENV:CLASSPATH"

If ($ENV:PROCESSOR_ARCHITECTURE -eq "AMD64")
{
  $ENV:ANT_OPTS="-Xmx4096m -Xss20m $ENV:ANT_OPTS"
}
Else
{
  $ENV:ANT_OPTS="-Xmx1500m -Xss20m $ENV:ANT_OPTS"
}
$ENV:ANT_OPTS="$ENV:ANT_OPTS -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl"

PrintAndValidatePath "PS_BASEPATH" $ENV:PS_BASEPATH
PrintAndValidatePath "PS_UTILITIES" $ENV:PS_UTILITIES
PrintAndValidatePath "PS_TOOLPATH" $ENV:PS_TOOLPATH
PrintAndValidatePath "PS_ERROROBJECTLOCATION" $ENV:PS_ERROROBJECTLOCATION
PrintAndValidatePath "PS_DITAOT" $ENV:PS_DITAOT
PrintAndValidatePath "JAVA_HOME" $ENV:JAVA_HOME
PrintAndValidatePath "JHHOME" $ENV:JHHOME
PrintAndValidatePath "AXF_DIR" $ENV:AXF_DIR
PrintAndValidateFilePath "AXF_OPT" $ENV:AXF_OPT
PrintAndValidatePath "XEP_DIR" $ENV:XEP_DIR
PrintAndValidatePath "PE_DIR" $ENV:PE_DIR
PrintAndValidatePath "HHCDIR" $ENV:HHCDIR
PrintParameter "PDF_FORMATTER" $ENV:PDF_FORMATTER
PrintParameter "PATH" $ENV:PATH
PrintParameter "CLASSPATH" $ENV:CLASSPATH
PrintParameter "ANT_OPTS" $ENV:ANT_OPTS
PrintParameter "TEMP" $ENV:TEMP
PrintParameter "TMP" $ENV:TMP
PrintParameter "PROCESSOR_ARCHITECTURE" $ENV:PROCESSOR_ARCHITECTURE
PrintParameter "DOMAIN\USERNAME" $ENV:USERDOMAIN\$ENV:USERNAME
