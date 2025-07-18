<#-- Macro: cMainFooter

Description: affiche un pied de page.

Parameters:
@param - title - string - required - nom du service numérique
@param - nested_pos - string - required - Position du contenu 'nested' passé dans la macro. Valeurs possible avant,'before' et aprés,'after'
@param - params - string - optionnal - permet d'ajouter des parametres HTML au tag footer
-->
<#macro cMainFooter title=mainSite nested_pos='after'  params='' deprecated...>
<@deprecatedWarning args=deprecated />
<div class="footer" role="content-info">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <div class="footer-col first">
                    <h4>${dskey('themecitelibre.site_property.footer.about.title')}</h4>
                    <p class="p-small">${dskey('themecitelibre.site_property.footer.about')}</p>
                </div>
            </div> <!-- end of col -->
            <div class="col-md-4">
                <div class="footer-col middle">
                    <h4>${dskey('themecitelibre.site_property.footer.links.title')}</h4>
                    <ul class="list-unstyled li-space-lg">
                        <#if nested_pos='before'>
                            <#nested>
                        </#if>
                        <li>
                            <i class="fas fa-lightbulb fa-fw"></i><a class="white p-small ms-2" href="https://lutece.paris.fr/support/wiki/home.html" target="_blank" title="[#i18n{portal.site.portal_footer.newWindow}] Wiki Lutece">Wiki</a>
                        </li>
                        <li>
                            <i class="fas fa-sitemap fa-fw"></i> 
                            <a class="white p-small ms-2" href="jsp/site/Portal.jsp?page=map" >#i18n{portal.site.site_map.pageTitle}</a>
                        </li>
                        <li>
                            <i class="fas fa-star fa-fw"></i>     
                            <a class="white p-small ms-2" href="jsp/site/PopupCredits.jsp" title="#i18n{portal.site.portal_footer.labelCredits}" data-bs-info="#i18n{portal.site.portal_footer.labelCredits}"  data-bs-toggle="modal" data-bs-target="#citelibreModal" >
                            #i18n{portal.site.portal_footer.labelCredits}
                            </a>
                        </li>
                        <li>
                            <i class="fas fa-info-circle fa-fw"></i>     
                            <a class="white p-small ms-2" href="jsp/site/PopupLegalInfo.jsp" title="#i18n{portal.site.portal_footer.labelInfo}" data-bs-info="#i18n{portal.site.portal_footer.labelInfo}" data-bs-toggle="modal" data-bs-target="#citelibreModal" >
                                #i18n{portal.site.portal_footer.labelInfo}
                            </a>
                        </li>
                        <li>
                            <i class="fas fa-universal-access fa-fw"></i>     
                            <a class="white p-small ms-2" href="#i18n{'themecitelibre.site_property.Url.accessibilityURL'}" title="#i18n{themecitelibre.site_property.Url.accessibilityLabel}">
                                #i18n{themecitelibre.site_property.Url.accessibilityLabel}
                            </a>
                        </li>
                        <#if nested_pos='after'>
                            <#nested>
                        </#if>
                    </ul>
                </div>
            </div> <!-- end of col -->
            <div class="col-md-4">
                <#if isContactInstalled?? && isContactInstalled>
                    <div class="footer-col last">
                        <h4>Contact</h4>
                        <ul class="list-unstyled li-space-lg">
                            <li>
                                <i class="far fa-address-book"></i> 
                                <a class="white p-small ms-2" href="jsp/site/Portal.jsp?page=contact&view=viewContactPage&id_contact_list=1&message_object=Ask%20for%20a%20demo&contact=1" title="Contact" > Contact</a>
                            </li>
                        </ul>
                    </div> 
                </#if>
                <div class="footer-col last">
                    <h4>${dskey('themecitelibre.site_property.footer.cookieLabel')}</h4>
                    <ul class="list-unstyled">
                        <li class="text-white p-small"> 
                            <a class="white p-small ms-2" id="tarteaucitronManagerLink" role="button" href="" title="${dskey('themecitelibre.site_property.footer.cookieLabel')}" >
                                   <svg xmlns="http://www.w3.org/2000/svg" height="16" width="16" fill="#fff" viewBox="0 0 512 512"><path d="M510.4 254.8l-12.1-76.3a132.5 132.5 0 0 0 -37.2-73l-54.8-54.8c-19.7-19.7-45.2-32.7-72.7-37.1l-76.7-12.2c-27.5-4.4-55.7 .1-80.5 12.8L107.3 49.6a132.3 132.3 0 0 0 -57.8 57.8l-35.1 68.9a132.6 132.6 0 0 0 -12.8 80.9l12.1 76.3a132.5 132.5 0 0 0 37.2 73l54.8 54.8a132.1 132.1 0 0 0 72.7 37.1l76.7 12.1c27.5 4.4 55.7-.1 80.5-12.8l69.1-35.2a132.3 132.3 0 0 0 57.8-57.8l35.1-68.9c12.7-25 17.2-53.3 12.8-81zM176 368c-17.7 0-32-14.3-32-32s14.3-32 32-32 32 14.3 32 32-14.3 32-32 32zm32-160c-17.7 0-32-14.3-32-32s14.3-32 32-32 32 14.3 32 32-14.3 32-32 32zm160 128c-17.7 0-32-14.3-32-32s14.3-32 32-32 32 14.3 32 32-14.3 32-32 32z"/></svg>
                                ${dskey('themecitelibre.site_property.footer.cookieLabel')}
                            </a>
                        </li>
                    </ul>
                </div> 
            </div> <!-- end of col -->
        </div> <!-- end of row -->
    </div> <!-- end of container -->
</div> <!-- end of footer -->  
<div class="modal fade" id="citelibreModal" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false"  aria-labelledby="citelibreModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="citelibreModalLabel">CiteLibre</h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="#i18n{portal.util.labelClose}"></button>
        </div>
        <div class="modal-body">
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-outline-sm" data-bs-dismiss="modal">#i18n{portal.util.labelClose}</button>
        </div>
      </div>
    </div>
</div>
<script>
function loadModalContent( url, body, sel ) {
    const xhr = new XMLHttpRequest();
	xhr.open('GET', url, true);
    xhr.onreadystatechange = () => {
        if (xhr.readyState == 4 && xhr.status == 200) {
			const response = xhr.responseText;
			// Convert the response to a temporary div to manipulate as DOM
			const qDiv = document.createElement('div');
    		qDiv.innerHTML = response;
		    // Use querySelector or getElementsByClassName to select elements
    		body.innerHTML = qDiv.querySelector( sel ).innerHTML;
		}
	}
    xhr.send();
};

const citelibreModal = document.getElementById('citelibreModal')
if (citelibreModal) {
    citelibreModal.addEventListener('show.bs.modal', event => {
    // Button that triggered the modal
    const link = event.relatedTarget
    // Update the modal's title.
    const title = link.getAttribute('data-bs-info')
    const modalTitle = citelibreModal.querySelector('.modal-title')
    modalTitle.textContent = `${title}`
    // Update the modal's content.
    const url = link.getAttribute('href')
    const modalBody = citelibreModal.querySelector('.modal-body')
    const content = loadModalContent( url, modalBody, '#main .container .row .col' );
    modalBody.innerHTML = content;
  })

// Set up click event for tarteaucitron manager
document.addEventListener('DOMContentLoaded', function() {
    const managerLink = document.getElementById('tarteaucitronManagerLink');
    if (managerLink) {
        managerLink.addEventListener('click', function(e) {
            e.preventDefault();
            if (typeof tarteaucitron !== 'undefined' && tarteaucitron.userInterface) {
                // Use the tarteaucitron API to open the panel
                tarteaucitron.userInterface.openPanel();
            } 
        });
    }
});
}
</script>
<@citelibreIconPack />
</#macro>