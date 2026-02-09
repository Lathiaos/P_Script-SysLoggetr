<#
.NOTES
	*****************************************************************************
    ETML
    Nom du script :	APE_CKI_SysLogger.ps1
    Auteurs       :	Arnaud Pré et Carl Kali
    Date          :	19.01.2026
 	*****************************************************************************
    Modifications
 	Date    : 19.01.2026
 	Auteurs : Arnaud Pré et Carl Kali
 	Raisons : Modifications demandées par le cadre du projet
 	*****************************************************************************
.SYNOPSIS
	Script PowerShell qui récupère certaines informations systèmes qui sont récupérées en remote
 	
.DESCRIPTION
    Description plus détaillée du script, avec les actions et les tests effectuées ainsi que les résultats possibles
  	
.PARAMETER FilePath
    Chemin du dossier qui va contenir le .log que le script va générer, contenant les informations journalisées
	
.PARAMETER EngineName
    Nom de la machine sur laquelle le script est exécuté
 	
.OUTPUTS
	Fichier .log avec les informations journalisées de la machine sur laquelle le script a été exécuté
	
.EXAMPLE
	.\CanevasV3.ps1 -FilePath Toto -EngineName Titi -Param3 Tutu
	La ligne que l'on tape pour l'exécution du script avec un choix de paramètres
	Résultat : par exemple un fichier, une modification, un message d'erreur
	
.EXAMPLE
	.\APE_CKI_SysLogger.ps1
	Résultat : Sans paramètre, affichage de l'aide
#>

<# Le nombre de paramètres doit correspondre à ceux définis dans l'en-tête
   Il est possible aussi qu'il n'y ait pas de paramètres mais des arguments
   Un paramètre peut être typé : [string]$FilePath
   Un paramètre peut être initialisé : $EngineName="Toto"
   Un paramètre peut être obligatoire : [Parameter(Mandatory=$True][string]$Param3
#>
# La définition des paramètres se trouve juste après l'en-tête et un commentaire sur le.s paramètre.s est obligatoire 
param($FilePath, $EngineName)

###################################################################################################################
# Zone de définition des variables et fonctions, avec exemples
$date = Get-Date -Format "le yyyy-MM-dd a HH-mm-ss"
###################################################################################################################
# Zone de tests comme les paramètres renseignés ou les droits administrateurs

# Affiche l'aide si un ou plusieurs paramètres ne sont par renseignés, "safe guard clauses" permet d'optimiser l'exécution et la lecture des scripts
if(!$FilePath)
{
    Get-Help $MyInvocation.Mycommand.Path
	exit
}

###################################################################################################################
# Corps du script

# Ce que fait le script, ici, afficher un message
if (-Not (Test-Path -Path $FilePath)){
    Write-Host "Le chemin specifie n'existe pas."
    exit
}

#Crée le fichier de log 
$logFile = Join-Path -Path $FilePath -ChildPath "sysloginfo.log"

#$cimSession = New-CimSession -ComputerName $EngineName -ErrorAction Stop

try {
Write-Output "$date
"`t"- Nom de l'ordinateur		: $((Get-CimInstance Win32_ComputerSystem).Name)
"`t"- Version			: $((Get-CimInstance Win32_OperatingSystem).Version)
"`t"- Infos systeme			: Build $((Get-CimInstance Win32_OperatingSystem).BuildNumber)
"`t"- Utilisation de l'espace disque: $((Get-CimInstance Win32_LogicalDisk | ForEach-Object { "$($_.DeviceID) $([math]::round($_.FreeSpace / 1GB, 1)) GB / $([math]::round($_.Size / 1GB, 1)) GB" }) -join "`n `t `t `t `t `t  ")
"`t"- RAM				: $(Get-CimInstance Win32_OperatingSystem | ForEach-Object { "$([math]::round($_.FreePhysicalMemory / 1MB, 2)) / $([math]::round($_.TotalVisibleMemorySize / 1MB, 2)) GB" })
"`t"- Programmes installes		: $((Get-CimInstance Win32_InstalledWin32Program | ForEach-Object { $_.Name  }) -join "`n `t `t `t `t `t  ")
"`t"- Uptime			: $(Get-CimInstance Win32_OperatingSystem | ForEach-Object { ((Get-Date) - $_.LastBootUpTime).ToString("dd\:hh\:mm\:ss") })" > $logFile
}
catch {
    Write-Host "Erreur lors de la récupération des informations système : $($_.Exception.Message)"
}
###################################################################################################################