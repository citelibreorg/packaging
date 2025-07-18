<#-- Macro: cConsentTac

Description: gère des Cookies CNIL ave cla librairie TarteAuCitron - https://tarteaucitron.io/fr /

Parameters:

@param - title - string - optional - le titre du consentement (par défaut: 'Ce site')
@param - privacyLink - string - optional - Lien vers la page de protection des données personnelles de Paris.fr (par défaut: '//www.paris.fr/pages/mentions-legales-235#confidentialite-et-protection-des-donnees')
@param - denyAll - boolean - optional - Option permettant d'afficher le bouton "Tout refuser" (par défaut: false)
@param - showIcon - boolean - optional - Option permettant d'afficher le bouton "Gestion des coookies" (par défaut: true)
@param - iconPostion - string - optional - Option permettant d'afficher le bouton "Gestion des coookies" à gauche ou à droite, en haut ou en bas (par défaut: 'bottomRight') 
@param - cookieMenu - string - optional - Libellé du ien footer pour gérer les cookies (par défaut: 'Gestion des cookies')
@param - cookiePolicyLink - string - optional - Lien vers la page Gestion des cookies de Paris.fr. (par défaut: 'https://www.paris.fr/pages/cookies-234')
@param - hashtag - string - optional - Identifiant pour modal de gestion du consentement (par défaut: 'cookiepolicycitelibre')
@param - cookiename - string - optional - Nom du cookie posé pour le consentement (par défaut: 'cookiecitelibre')
@param - nocredit - boolean - optional - Option permettant d'afficher les crédit du projet TarteAuCitron (par défaut: false)
 -->
<#macro cConsentTac title='Ce site' privacyLink='//www.paris.fr/pages/mentions-legales-235#confidentialite-et-protection-des-donnees' denyAll=false showIcon=true iconPosition='bottomRight' cookieMenu='Gestion des cookies' cookiePolicyLink='https://www.paris.fr/pages/cookies-234' hashtag='cookiepolicycitelibre' cookiename='cookiecitelibre' nocredit=false  deprecated...>
<@deprecatedWarning args=deprecated />
<link rel="stylesheet" href="${commonsSiteThemePath}${commonsSiteJsPath}vendor/tarteaucitron/css/theme-citelibre-tac.min.css" >
<script src="${commonsSiteThemePath}${commonsSiteJsPath}vendor/tarteaucitron/tarteaucitron.min.js"></script>
<!-- Service Mon Paris -->
<script>
tarteaucitron.services.monparis={
  "key": "monparis",
  "type": "api",
  "name": "Mon Paris",
  "uri": "https://moncompte.paris.fr",
  "readmoreLink": "${cookiePolicyLink}",
  "needconsent": false,
  "useExternalCss" : true,
  "mandatory": true,
  "cookies": ['mcpAuth','JSESSIONID','AUTH_SESSION_ID','KEYCLOAK_IDENTITY','KEYCLOAK_SESSION'],
  "js": function () {
    "use strict";
    // When user allow cookie
  },
  "fallback": function () {
    "use strict";
    // when use deny cookie
  }
};
tarteaucitron.init({
    "bodyPosition": "top",          /* Tag positionné en haut pour accessibilité */
    "privacyUrl": "${privacyLink}", /* Privacy policy url */
    "hashtag": "#${hashtag}",       /* Open the panel with this hashtag */
    "cookieName": "${cookiename}",  /* Cookie name */
    "orientation": "bottom",        /* Banner position (top - bottom) */
    "groupServices": false,         /* Group services by category */
    "showDetailsOnClick": true,     /* Click to expand the description */
    "serviceDefaultState": "wait",  /* Default state (true - wait - false) */
    "showAlertSmall": false,        /* Show the small banner on bottom right */
    "showIcon": ${showIcon?c},        /* Show cookie icon to manage cookies */
    // "iconSrc": "",               /* Optional: URL or base64 encoded image */
    "iconPosition": "${iconPosition}", /* Position of the icon between BottomRight, BottomLeft, TopRight and TopLeft */
    "cookieslist": true,            /* Show the cookie list */
    "adblocker": true,              /* Show a Warning if an adblocker is detected */
    "AcceptAllCta" : true,          /* Show the accept all button when highPrivacy on */
    "DenyAllCta" : ${denyAll?c},    /* Show the Deny all button when highPrivacy on */
    "highPrivacy": true,            /* Disable auto consent */
    "alwaysNeedConsent": true,      /* Ask the consent for "Privacy by design" services */
    "handleBrowserDNTRequest": true,/* If Do Not Track == 1, disallow all */
    "removeCredit": ${nocredit?c},  /* Remove credit link */
    "moreInfoLink": true,           /* Show more info link */
    "useExternalCss": true,         /* If false, the tarteaucitron.css file will be loaded */        
    "readmoreLink": "${cookiePolicyLink}", /* Change the default readmore link */
    "mandatory": true,              /* Show a message about mandatory cookies */
    "mandatoryCta": true,           /* Show the disabled accept button when mandatory on */

    "customCloserId": "tac",        /* Optional a11y: Custom element ID used to open the panel */

    "googleConsentMode": true,      /* Enable Google Consent Mode v2 for Google ads and GA4 */
    "bingConsentMode": true,        /* Enable Bing Consent Mode for Clarity and Bing Ads */
    "softConsentMode": false,       /* Soft consent mode (consent is required to load the services) */

    "dataLayer": false,             /* Send an event to dataLayer with the services status */
    "serverSide": false,            /* Server side only, tags are not loaded client side */
    "partnersList": true            /* Details the number of partners on the popup and middle banner */
});
<#nested>
</script>
</#macro>