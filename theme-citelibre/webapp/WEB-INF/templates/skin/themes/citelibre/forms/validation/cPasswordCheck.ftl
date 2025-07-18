<#-- Macro: cPasswordCheck

Description: permet de définir le message d'erreur d'un champs.

Parameters:

@param - id - string - required - l'ID du champs password
-->
<#macro cPasswordCheck id >
<#local checkMsg><@cInline class='charlength'><@citelibreIcon name='check' /> #i18n{themecitelibre.labelNbChars}</@cInline> <@cInline class='uppercase'><@citelibreIcon name='check' /> #i18n{themecitelibre.labelNbUppercase} </@cInline> <@cInline class='digit'><@citelibreIcon name='check' /> #i18n{themecitelibre.labelNbDigit}</@cInline></#local>
<@cFormHelp id checkMsg />
</#macro>