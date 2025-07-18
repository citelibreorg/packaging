<#-- Macro: cMainNav

Description: affiche une barre de navigation.

Parameters:
@param - id - string - optional - identifiant unique de la barre de navigation
@param - class - string - optional - classe(s) css de la barre de navigation
@param - title - string - required - Titre du site. Par défaut récupère le nom de la variable "favorite".
@param - logoImg - string - required - url de l'image utilisée comme logo pour le titre du site
@param - href - string - required - url de redirection sur le logo du titre du site
@param - hasMenu - boolean - required -  si true, le site possède un menu
@param - hasNestedMenu - boolean - optionnal -  si true, le site possède un menu
@param - isSidebar - boolean - required -  si true, le menu sera vertical calé à gauche
@param - isOnlyHome - boolean - required -  si true, le menu ne sera affiché que sur la page d'accueil
@param - isSibebarCollapsible - boolean - required -  si true, le menu pourra être masqué
@param - sidebarMenuClass - string - optionnal -  Ajoute une classe au menu vertical. Par défaut vide.
@param - showDefaultMenu - boolean - required -  si true, affiche le menu
@param - hasSearchMenu - boolean - required -  si true, ajoute la rercherche au menu
@param - typeSearch - string - required -  Si Field, ajoute le champs de rercherche sinon un lien paramètre sur l'url de recherche précisée dans les paramètres les propriétés du site. Si la valeur est button une icone de recherche sera positionnée après le menu.
@param - searchUrl - string - required -  Url pour l'icone de recherche. Par défaut récupère la valeur de l'url de recherche précisée dans les paramètres les propriétés du site.
@param - searchAction - string - required -  Url d'action pour le formulaire nécessite typeSearch='field'
@param - searchSolr - boolean - required - si "true" fait la recherche sur Solr et non sur le moteur de recherche par défaut.
@param - searchParams - string - optional - tous champs à ajouter au formulaire nécessitent typeSearch='field'
@param - hasLogin - boolean - required - si true, le site est authentifié et propose un bouton de login (connexion Mon Paris)
@param - loginClass - string - optional - classe CSS pour le bouton de login
@param - mainClass - string - optional - classe CSS pour la balise main
@param - role - string - required - role aria par défaut
@param - params - string - optional - permet d'ajouter des paramètres HTML à la barre de navigation
-->
<#macro cMainNav title=favourite logoImg='' href='.' hasMenu=hasDefaultMenu?boolean hasNestedMenu=true isSidebar=isMainSidebarMenu?boolean isSibebarCollapsible=isMainSidebarMenuCollapse?boolean sidebarMenuClass='' isOnlyHome=isBannerOnlyHome showDefaultMenu=true hasSearchMenu=false typeSearch='field' searchUrl=urlDefaultSearch searchAction='jsp/site/Portal.jsp' searchSolr=false searchParams='' isFixed=isFixedMenu?boolean hasLogin=true loginClass='' mainClass='' id='' class='' role='' params='' deprecated...>
<@deprecatedWarning args=deprecated />
<#assign pageId><#if page_id??>${page_id}<#else>0</#if></#assign>
<header class="theme-main-header<#if isFixed> is-fixed</#if><#if hasBanner?boolean><#if isOnlyHome><#if pageId?number = 1> has-banner</#if><#else> has-banner</#if></#if>" id="main-banner-${page_id!'themecitelibre'}" role="banner">
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom fixed-top<#if class !='' > ${class!}</#if>"<#if id !='' > id="${id!}"</#if><#if params!=''> ${params}</#if> aria-label="" role="navigation">
    <div class="container">
        <!-- Text Logo - Use this if you don't have a graphic logo -->
        <!-- <a class="navbar-brand logo-text page-scroll" href="index.html">Tivo</a> -->
        <!-- Image Logo -->
        <a class="navbar-brand logo-image text-decoration-none" href=".">
            <img src="images/logo-pack-light.min.svg" alt="alternative">
        </a> 
        <!-- Mobile Menu Toggle Button -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar-citelibre" aria-controls="navbarscitelibreDefault" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-menu ti ti-menu-2"></span>
            <span class="navbar-toggler-menu ti ti-x"></span>
        </button>
        <!-- end of mobile menu toggle button -->
        <div class="collapse navbar-collapse" id="navbar-citelibre">
        <#if hasMenu>
            <#assign menu=page_main_menu!>
            <ul class="navbar-nav navbar-main align-items-center ms-auto">
                <li class="nav-item">
                    <a class="nav-link page-scroll" href="jsp/site/Portal.jsp#header">#i18n{portal.site.page_home.label} <span class="visually-hidden">(#i18n{portal.site.page_home.label})</span></a>
                </li>
                ${page_main_menu_html!menu}
                <#nested>
                <#if hasSearchMenu>
                    <nav class="navbar-menu-search ml-auto" aria-label="" role="navigation">
                        <form class="form-inline" role="search" action="${urlSearch!}" method="get">
                            <input type="hidden" name="page" value="search-solr">
                            <input type="hidden" name="fq" value="type:formsResponse">
                            <div class="input-group">
                                <input type="text" name="query" id="query" class="form-control mr-sm-2" placeholder="#i18n{portal.site.page_menu_tools.labelSearch}" aria-label="#i18n{portal.site.page_menu_tools.labelSearch}" aria-describedby="button-main-search">
                                <div class="input-group-append">
                                    <button id="button-main-search" class="btn btn-link" type="submit">
                                        <@cIcon class='search' label='#i18n{portal.site.page_menu_tools.labelSearch}' />
                                    </button>
                                </div>
                            </div>
                        </form>  
                    </nav>
                </#if>
            	<li class="nav-item">
                    <a class="nav-link" title="LUTECE [Nouvelle fenêtre]" target="_blank" href="https://lutece.paris.fr/">LUTECE</a>
                </li>
	            <li class="nav-item">
		            <a class="nav-link" href="jsp/site/Portal.jsp?page=contact&amp;view=viewContactPage&amp;id_contact_list=1&amp;message_object=Ask%20for%20a%20demo&amp;contact=1" title="contacts">CONTACT</a>
	            </li>
                <li class="nav-item">
                    <#if hasLogin>${pageinclude_userlogin?default("")}</#if>
                </li>
                <li class="nav-item ms-2">
                    <a href="/fr/">
                        <img class="img-fluid" width="18" src="images/fr.svg" alt="fr" title="Français">
                        <span class="visually-hidden">Français</span>
                    </a>
                </li>
	            <li class="nav-item ms-2">
                    <a href="/en/">
                        <img class="img-fluid" width="18" src="images/uk.svg" alt="en" title="English">
                        <span class="visually-hidden">English</span>
                    </a>
                </li>
                <li class="nav-item">    
                    <label class="nav-dark-mode" for="darkSwitch" title="Switch Dark/light mode"><span class="visually-hidden">Dark Mode </span>
                        <input type="checkbox" id="darkSwitch" class="visually-hidden" />
                        <i class="fa fa-sun"></i><i class="fa fa-moon"></i>
                    </label>
                </li>
            </ul>
        </#if>
        </div>
    </div> <!-- end of container -->
</nav> <!-- end of navbar -->
<!-- end of navigation -->
</header>
<main id="main"<#if mainClass !=''> class="${mainClass!}"</#if> role="main">
</#macro>