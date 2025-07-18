<#-- Macro: cStepGroup

Description: Defines a macro that show a step group

Parameters:
@param - title - string - optional - required - the title of the group
@param - help - string - optional - 
@param - class - string - optional - the CSS class of the element, default '' 
@param - id - string - optional - the ID of the element, default ''
@param - value - string - optional - the value of the element, default ''
@param - iterable - boolean - optional - Add box to the checkbox, default false 
@param - iteration - number - optional - Number of iteration default 0
@param - iterationMax - number - optional - Number of max iteration possible default 10
@param - labelAddIteration - string - optional - Label to add an iteration, default '#i18n{themecitelibre.labelAdd}'
@param - labelDelIteration - string - optional - Label to remove an iteration, default '#i18n{themecitelibre.labelDelete}'
@param - headerParams - string - optional - additional HTML attributes to include in the header of step group element default ''
@param - params - string - optional - additional HTML attributes to include in the parent block element default ''
-->
<#macro cStepGroup title iterable=false iteration=0 iterationMax=10 labelAddIteration='#i18n{themecitelibre.labelAdd}' labelDelIteration='#i18n{themecitelibre.labelDelete}' headerParams='' help='' class='' id='' params='' deprecated...>
<@deprecatedWarning args=deprecated />
<@cRow>
	<@cCol>
		<@cContainer>
			<@cFieldset class='w-100 flex-fill row step-group ${class!}' id=id params=params >
				<#local legendClass><#if iterable && iteration gt 0>d-flex align-items-center</#if></#local>
				<#local legend>
					<@cInline class='h3 title main-info-color'>${title!}<#if iteration gt 0> (${iteration+1})</#if></@cInline>
					<#if iterable && iteration gt 0>
					<@cBtn label='' class='danger btn-mini me-sm mt-0' params='name="action_removeIteration" value="rm_${iteration}"' >
						<@citelibreIcon name='trash' /><@cInline class='btn-label'>${labelDelIteration}</@cInline>
					</@cBtn>
					</#if>
				</#local>
				<@cLegend label=legend class=legendClass params=headerParams />
				<#if help!=''>
					<@cRow>
						<@cCol>${help}</@cCol>
					</@cRow>
				</#if>
				<#nested>
				<#if iterable && iteration lte iterationMax>
					<@cRow>
						<@cCol class='d-flex justify-content-end'>
							<@cBtn label='' class='action ms-m' params='name="action_addIteration" value="add_${iteration}"'>
								<@citelibreIcon name='plus' /><@cInline class='btn-label'>${labelAddIteration}</@cInline>
							</@cBtn>
						</@cCol>
					</@cRow>
				</#if>
			</@cFieldset>
		</@cContainer>
	</@cCol>
</@cRow>
</#macro>