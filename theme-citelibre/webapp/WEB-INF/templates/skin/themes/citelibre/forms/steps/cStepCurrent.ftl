<#-- Macro: cStepCurrent

Description: Defines a macro that show the current step

Parameters:
@param - step - string - optional - required - Step number
@param - title - string - optional - required - the title of the step
@param - showTitle - boolean - optional - Show step title, default true 
@param - titleLevel - number - optional - HTML level of the title tag, default 2
@param - class - string - optional - the CSS class of the element, default '' 
@param - actionNextStep - string - optional - If set add a next step button, default ''
@param - titleNextStep - string - optional - If set add a title for next step button, default ''
@param - labelNextStep - string - optional - Label of the next button '#i18n{themecitelibre.labelNextStep}'
@param - actionPrevStep - string - optional - If set add a previous step button, default ''
@param - titlePrevStep - string - optional - If set add a title for prev step button, default ''
@param - labelPrevStep - string - optional - Label of the previous step button, default '#i18n{themecitelibre.labelPrevStep}'
@param - actionSaveStep - string - optional - If set add a save step button, default ''
@param - titleSaveStep - string - optional - If set add a title for save step button, default ''
@param - labelSaveStep - string - optional - Label of the save step button , default '#i18n{themecitelibre.labelSaveStep}'
@param - actionSaveForBackUpStep - string - optional - If set add a save step for backup button, default ''
@param - titleSaveForBackUpStep - string - optional - If set add a title for "SaveForBackUpStep" step button, default ''
@param - labelSaveForBackUpStep - string - optional - Label of the save backup button, default '#i18n{forms.step.saveResponse}'
@param - actionResetBackUpStep - string - optional - If set add a reset backup button, default ''
@param - titleResetBackUpStep - string - optional - If set add a title for reset backup step button, default ''
@param - labelResetBackUpStep - string - optional - Label of the reset backup button, default '#i18n{forms.step.resetResponse}'
@param - showPrevStep - boolean - optional - Show previous step button, default true 
@param - hasSteps - boolean - optional - Show step infos in header of step, default true 
@param - hasMandatory - boolean - optional - Add mandatory warning, default true 
@param - params - string - optional - additional HTML attributes to include in the parent block element default ''
-->
<#macro cStepCurrent step title showTitle=true titleLevel=3 actionNextStep='' titleNextStep='' labelNextStep='#i18n{themecitelibre.labelNextStep}' actionPrevStep='' titlePrevStep='' labelPrevStep='#i18n{themecitelibre.labelPrevStep}' actionSaveStep='' titleSaveStep='' labelSaveStep='#i18n{themecitelibre.labelSaveStep}' actionSaveForBackUpStep='' titleSaveForBackUpStep='' labelForBackUpStep='#i18n{forms.step.saveResponse}' actionResetBackUpStep='' titleResetBackUpStep='' labelResetBackUpStep='#i18n{forms.step.resetResponse}' showPrevStep=true hasSteps=true hasMandatory=true class='' params='' deprecated...>
<@deprecatedWarning args=deprecated />
<@cSection id='current_step' class='step step-current ${class!}' params=params >
<#if showTitle>
<@cSection class='step-title'>
	<@cContainer>
		<#if hasSteps>
			<@cTitle class='title' level=titleLevel params='data-step="${step}" title="${title} - #i18n{themecitelibre.labelCurrentStep}" aria-current="step"'>
				<@cText type='span' class='step-number'>${step}</@cText>
				<@cText type='span'>${title}</@cText>
			</@cTitle>
		<#else>
			<@cTitle level=titleLevel class='title no-step' params='title="${title} - #i18n{themecitelibre.labelCurrentStep}"'>${title}</@cTitle>
		</#if>
	</@cContainer>
</@cSection>
</#if>
<@cContainer>
<@cSection class="step-content">
	<#if hasMandatory>
		<@cFormRow>
			<@cCol>
				<@cText class="mandatory-warning">#i18n{themecitelibre.msgMandatory}</@cText>
			</@cCol>
		</@cFormRow>
	</#if>
	<#nested>
	<@cFormRow>	
		<@cCol class='d-flex justify-content-center justify-content-sm-end mb-l'>
			<@chList class='list-unstyled d-flex justify-content-end flex-column flex-sm-row align-items-center'>
			<#if actionNextStep !=''>
				<#assign paramsNextStep> name="${actionNextStep}"<#if titleNextStep !=''> title="${titleNextStep}"</#if></#assign>
				<@chItem class='order-5'>
					<@cBtn class='main mt-xs ms-sm' id=actionNextStep params=paramsNextStep label=labelNextStep />
				</@chItem>
			</#if>    
			<#if actionSaveStep !=''>    
				<#assign paramsSaveStep> name="${actionSaveStep}" formnovalidate<#if titleSaveStep !=''> title="${titleSaveStep}"</#if></#assign>
				<@chItem class='order-5'>
					<@cBtn class='main' id=actionSaveStep params=paramsSaveStep label=labelSaveStep />
				</@chItem>
			</#if>
			<#if actionPrevStep !='' && showPrevStep >
				<#assign paramsPrevStep> name="${actionPrevStep}" formnovalidate<#if titlePrevStep !=''> title="${titlePrevStep}"</#if></#assign>
				<@chItem class='order-2'>
					<@cBtn class='main ms-sm' id=actionPrevStep params=paramsPrevStep label=labelPrevStep />
				</@chItem>
			</#if> 
			<#if actionSaveForBackUpStep !=''>
				<#assign paramsSaveForBackUpStep> name="${actionSaveForBackUpStep}" formnovalidate<#if titleSaveForBackUpStep !=''> title="${titleSaveForBackUpStep}"</#if></#assign>
				<@chItem class='order-3'>
					<@cBtn class='outline-main ms-sm' id=actionSaveForBackUpStep params=paramsSaveForBackUpStep label='#i18n{themecitelibre.labelSaveStep}' />
				</@chItem>
			</#if>
			<#if actionResetBackUpStep !=''>    
				<#assign paramsResetBackUpStep> name="${actionResetBackUpStep}" formnovalidate<#if titleResetBackUpStep !=''> title="${titleResetBackUpStep}"</#if></#assign>
				<@chItem id='reset-backup' class='order-4 visually-hidden'>
					<@cBtn class='outline-main ms-sm' id=actionResetBackUpStep params=paramsResetBackUpStep label=labelResetBackUpStep />
				</@chItem>
			</#if>
			</@chList>
		</@cCol>
	</@cFormRow>
</@cSection>
</@cContainer>
</@cSection>
<@cModal title='Supprimer la sauvegarde' dismissLabel='Non revenir sur ma démarche' id='reset-step' footer='<button class="btn btn-action" id="modal-reset-backup" type="button"><span class="btn-label">Oui supprimer les informations</span></button>' />
<script>
window.addEventListener('DOMContentLoaded', (event) => {
<#if step?number gt 1 >
	const current = document.querySelector('#current_step');
	const y = current.offsetTop - 180;
	window.scrollBy(0, y);
	<#assign actionStep><#if actionNextStep !=''>${actionNextStep!}<#else>${actionSaveStep!}</#if></#assign>
	const formValidateButton = document.querySelector('#${actionStep!}');
	formValidateButton.addEventListener('click', (e) => {
		const invalids = document.querySelectorAll('.form-control:invalid','.form-control:user-invalid');
		const arrInvalids = Array.prototype.slice.call(invalids);
		arrInvalids.forEach( function( invalid ){
			invalid.classList.add('is-invalid')
			invalid.setAttribute('aria-invalid', 'true');
			const isRequired = invalid.getAttributeNode('required'); 
			if( isRequired !='' ){
				let pInvalid = document.createElement("p");
				pInvalid.classList.add( 'invalid-feedback' );
				pInvalid.setAttribute( 'role', 'alert' );
				<#assign invalidLabel>#i18n{themecitelibre.msgMandatory}</#assign>
				pInvalid.innerHTML = `${invalidLabel}`;
				if (invalid.closest('.input-group') != null) {
					invalid.closest('.input-group').after(pInvalid);
				} else {
					invalid.after(pInvalid);
				}
			}
		});
	})
</#if>
	const saveStep = document.getElementById('save-step-status');
	if(saveStep){
		const at = saveStep.querySelector('.alert-title');
		const btnReset = document.createElement('button');
		btnReset.classList.add('btn', 'btn-outline-main', 'ms-sm');
		btnReset.innerHTML = 'Supprimer la sauvergarde';
		btnReset.setAttribute('type', 'button');
		btnReset.setAttribute('data-bs-target', '#reset-stepModal');
		btnReset.setAttribute('data-bs-toggle', 'modal');
		at.appendChild(btnReset);

		const btnModalReset = document.querySelector('#modal-reset-backup');
		btnModalReset.addEventListener('click', (e) => {
			const resetBackup = document.getElementById('${actionResetBackUpStep}');
			resetBackup.click();
		});
	}
});
</script> 
</#macro>