<#-- Name : cDivider            -->
<#-- Attributes List  :         -->
<#-- type  : pill, default ""   -->
<#-- id                         -->
<#-- class                      -->
<#-- params                     -->
<#macro cDivider label='#i18n{themecitelibre.labelOr}' class='' id='' params='' deprecated...>
<@deprecatedWarning args=deprecated />
<p class="divider<#if class != ''> ${class}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>${label!}</p>
</#macro>