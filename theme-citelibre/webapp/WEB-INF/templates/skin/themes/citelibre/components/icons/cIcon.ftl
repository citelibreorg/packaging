<#-- icon
deprecated
 -->
<#macro cIcon class label='' id='' params='' prefix='ti ti-' type='span' deprecated...>
<@deprecatedWarning args=deprecated />
<${type!} class="${prefix!}${class!}" aria-hidden="true"></${type!}>
</#macro>