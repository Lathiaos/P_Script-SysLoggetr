<#
.NOTES
    *****************************************************************************
    ETML
    Nom du script :	Arnaud Pré et Mateen Khalil - Script PS - Projet 122
    Auteurs       : Arnaud Pré et Mateen Khalil
    Date          :	19.01.2026
 	*****************************************************************************
    Modifications
 	Date    : 19.01.2026
 	Auteurs : Arnaud Pré et Mateen Khalil
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
	Fichier .log avec les informations journalisées de la machine sur laquelle le script a été exécuté5
	
.EXAMPLE
	.\CanevasV3.ps1 -FilePath Toto -EngineName Titi -Param3 Tutu
	La ligne que l'on tape pour l'exécution du script avec un choix de paramètres
	Résultat : par exemple un fichier, une modification, un message d'erreur
	
.EXAMPLE
	.\APE_MKL_SysLogger.ps1
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
Write-Host "coucou"
    



