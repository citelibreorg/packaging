<#-- Macro: cAlert

Description: affiche une bannière d'alerte.

Parameters:
@param - id - string - optional - l'ID de l'alert
@param - title - string - optional - le titre de l'alert (par défaut : '#i18n{themecitelibre.labelWarning}')
@param - class - string - optional - permet d'ajouter une classe CSS prefixée 'alert-' à l'alert (par défaut : 'primary')
@param - classText - string - optional - permet d'ajouter une classe CSS au texte de l'alert (par défaut : 'primary')
@param - dismissible - boolean - optional - permet d'activer la fermeture de l'alert (par défaut: true)
@param - params - string - optional - permet d'ajouter des parametres HTML à l'alert
-->
<#macro cAlert id='' title='' titleClass='h5' class='primary' classText='' dismissible=false params='' deprecated...>
<@deprecatedWarning args=deprecated />
<#local citelibreIconName='alert-info' />
<#local citelibreIconTitle='#i18n{themecitelibre.labelInfo}' />
<#local ariaRole='status' />
<#if class?starts_with('danger')>
<#local citelibreIconTitle='#i18n{themecitelibre.labelError}' />
<#local citelibreIconName='alert-danger' /> 
<#local ariaRole='alert' />
<#elseif class?starts_with('warning')>
<#local citelibreIconTitle='#i18n{themecitelibre.labelWarning}' />
<#local citelibreIconName='alert-warning' />
<#local ariaRole='alert' />
<#elseif class?starts_with('success')>
<#local citelibreIconTitle='#i18n{themecitelibre.labelSuccess}' />
<#local citelibreIconName='alert-check' />
<#local ariaRole='status' />
</#if>
<#local alertClass>alert alert-${class}<#if title =''> flex-row</#if><#if dismissible> alert-dismissible fade show</#if></#local>
<@cBlock class=alertClass! params='role="${ariaRole!}" ${params!}' id=id!>
    <@cHeader class='alert-header'>
        <@cBlock class='alert-icon'><@cIcon label=citelibreIconTitle! class='info-circle fa-2x' /></@cBlock>
        <#if title !=''><@cTitle level=2 class='alert-title ${titleClass}'>${title!}</@cTitle></#if>
        <#if dismissible>
        <@cBlock class="alert-dismiss">
            <@cBtn type='button' label='' class='btn-close' params='data-bs-dismiss="alert" aria-label="#i18n{themecitelibre.labelClose}"' />
        </@cBlock>
        </#if>
    </@cHeader>
    <#local _nested><#nested /></#local>
    <#if _nested?? && _nested !=''><@cBlock class='alert-content'>${_nested}</@cBlock></#if>
</@cBlock>
</#macro>