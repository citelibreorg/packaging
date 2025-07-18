<#-- Macro: cMainNavUser

Description: affiche le menu utilisateur.

Parameters:
@param - id - string - optional - identifiant unique du menu
@param - class - string - optional - classe(s) css du menu
@param - connected - boolean - required - indique si une connexion utilisateur existe
@param - userName - boolean - required - nom de l'utilisateur si connecté
@param - urlConnect - string - required - url de connexion ou de déconnexion
@param - btnToggle - boolean - required -  ouvre le menu dans un dropdown
@param - userFullName - string - optional - nom de l'utilisateur à afficher
@param - userEmail - string - optional - email de l'utilisateur à afficher
@param - userInitials - string - optional - initiales de l'utilisateur à afficher
@param - hasIcon - boolean - required - permet d'afficher ou non l'icone utilisateur
@param - title - string - required - libellé pour les icônes
@param - params - string - optional - permet d'ajouter des paramètres HTML au menu
-->
<#macro cMainNavUser connected userName urlConnect='jsp/site/Portal.jsp?page=mylutece&action=login' btnToggle=true userFullName='' userEmail='' userInitials='' hasIcon=false title='#i18n{themecitelibre.labelConnect}' id='' class='' params='' deprecated...>
<@deprecatedWarning args=deprecated />
<#if !connected>
    <span class="nav-item">
        <a class="btn btn-outline-main" href="${urlConnect!}">#i18n{themecitelibre.labelConnect}</a>
    </span>
<#else>
    <li class="nav-item dropdown<#if class !='' > ${class!}</#if>"<#if id !='' > id="${id!}"</#if><#if params!=''> ${params}</#if>">
        <a class="btn btn-outline-main dropdown-toggle disabled" href="#" id="navbarDropdown" role="button" aria-haspopup="true" aria-expanded="false">${userName?upper_case} </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
            <a class="dropdown-item" href="${urlConnect!}" title="#i18n{themecitelibre.titleDisconnect}">
                <i class="fa fa-power-off" aria-hidden="true"></i> 
                <span>#i18n{themecitelibre.labelDisconnect}</span>  
            </a>
        </div>
    </li>
</#if>
</#macro>