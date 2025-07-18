<#-- Macro: citelibreIcon

Description: affiche une icône.

Parameters:
@param - id - string - optional - identifiant unique de l'icône
@param - class - string - optional - classe(s) css de l'icône
@param - name - string - required - nom de l'icône, title
@param - type - string - optional - type de l'icon pour l'accessibilité (défaut: "decorative", valeurs possibles: "decorative", "informative")
@param - title - string - optional - titre de l'icon
@param - params - string - optional - permet d'ajouter des paramètres HTML à l'icône
-->
<#macro citelibreIcon name type='decorative' id='' class='' title='' params='' deprecated...>
<@deprecatedWarning args=deprecated />
<#local rId=random() /> 
<svg class="citelibre-icon citelibre-icon-${name!}<#if class!=''> ${class!}</#if>"<#if id!=''> id="${id!}"</#if>data-mce-svg="citelibre-icon paris-icon-${name!}" <#if type !='decorative' && title!=''> aria-labelledby="paris-icon-${name!}-paris-title-${rId}"<#elseif type='decorative'>aria-hidden="true"</#if> focusable="false" role="img"<#if params!=''> ${params!}</#if>>
<#if type !='decorative' && title!=''><title id="citelibre-icon-${name!}-citelibre-title-${rId}">${title}</title></#if>
<use xlink:href="#citelibre-icon-${name!}"></use>
</svg>
</#macro>