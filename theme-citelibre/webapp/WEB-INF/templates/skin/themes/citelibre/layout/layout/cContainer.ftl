<#-- Macro: cContainer

Description: affiche un container.

Parameters:
@param - id - string - optional - identifiant unique du container
@param - class - string - optional - classe(s) css du container
@param - type - string - optional - le type de container, en ajoutant la valeur '-fluid' il prend toute la largeur
@param - params - string - optional - permet d'ajouter des paramètres HTML au container
-->
<#macro cContainer type='' class='' id='' params='' deprecated...>
<@deprecatedWarning args=deprecated />
<#if class!=''>
    <#local cClass>container<#if type!=''>-${type}</#if> ${class}</#local> 
<#else>
    <#local cClass>container<#if type!=''>-fluid</#if></#local>
</#if>
<@cSection type='div' class=cClass id=id params=params>
<#nested>
</@cSection>
</#macro>