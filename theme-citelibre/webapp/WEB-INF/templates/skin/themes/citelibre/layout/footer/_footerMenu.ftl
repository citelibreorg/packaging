<#-- Macro: _footerMenu

Description: Private only used in cMainFooter and cMainFooterSocial macros

Parameters:
-->
<#macro _footerMenu>
<@cMainNavItem title='${mainSite}' url=urlMainSite role='' target='_blank' />
<#if hasSiteMap?boolean>
<@cMainNavItem title='#i18n{portal.site.site_map.pathLabel} 'role='' url="jsp/site/Portal.jsp?page=map" />
</#if>
<#if footerLinkContact !=''>
<#if !dskey('themecitelibre.site_property.Url.contactURLLabel')?starts_with('DS') && dskey('themecitelibre.site_property.Url.contactURLLabel') !=''>
<#local title=dskey('themecitelibre.site_property.Url.contactURLLabel') /><#else><#local title='#i18n{themecitelibre.labelContact}' /></#if>
<@cMainNavItem title=title url=footerLinkContact role='' target='_blank' />
</#if>
<#if footerLinkLegal !=''>
<#if !dskey('themecitelibre.site_property.Url.legalURLLabel')?starts_with('DS') && dskey('themecitelibre.site_property.Url.legalURLLabel') !=''>
<#local title=dskey('themecitelibre.site_property.Url.legalURLLabel') /><#else><#local title='#i18n{themecitelibre.labelLegalInfo}' /></#if>
<@cMainNavItem title=title url=footerLinkLegal role='' target='_blank'  />
</#if>
<#if footerLinkCgu !=''>
<#if !dskey('themecitelibre.site_property.Url.cguURLLabel')?starts_with('DS') && dskey('themecitelibre.site_property.Url.cguURLLabel') !=''>
<#local title=dskey('themecitelibre.site_property.Url.cguURLLabel') /><#else><#local title='#i18n{themecitelibre.labelCgu}' /></#if>
<@cMainNavItem title=title url=footerLinkCgu role='' target='_blank' />
</#if>
<#if footerLinkDataProtection !=''>
<#if !dskey('themecitelibre.site_property.Url.dataURLLabel')?starts_with('DS') && dskey('themecitelibre.site_property.Url.dataURLLabel') !=''>
<#local title=dskey('themecitelibre.site_property.Url.dataURLLabel') /><#else><#local title='#i18n{themecitelibre.labelDataProtection}' /></#if>
<@cMainNavItem title=title url=footerLinkDataProtection role='' target='_blank' />
</#if>
<#if footerLinkAccessibility !=''>
<#if !dskey('themecitelibre.site_property.Url.accessibilityLabel')?starts_with('DS') && dskey('themecitelibre.site_property.Url.accessibilityLabel') !=''>
<#local title=dskey('themecitelibre.site_property.Url.accessibilityLabel') /><#else><#local title='#i18n{themecitelibre.labelAccessibility}' /></#if>
<@cMainNavItem title=title url=footerLinkAccessibility role='' target='_blank' />
</#if>
<#if !dskey('themecitelibre.site_property.Url.cookieURLLabel')?starts_with('DS') && dskey('themecitelibre.site_property.Url.cookieURLLabel') !=''>
<#local title=dskey('themecitelibre.site_property.Url.cookieURLLabel') /><#else><#local title='#i18n{themecitelibre.labelCookies}' /></#if>
<@cMainNavItem title=title url=footerLinkCookies role='' target='_blank' />
</#macro>