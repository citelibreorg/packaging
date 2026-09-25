# Dépendances : plages de versions ouvertes

_Rapport mis à jour le 2026-09-25, Maven 3.9.16. Profils analysés avec `-Passembly,<profil>`._

## Problème

Beaucoup de modules Lutece déclarent leurs dépendances avec des plages ouvertes (`[x,)` = « x ou plus récent »). Le dépôt `luteceSnapshot` est activé avec `snapshots enabled=true`, donc Maven prend la plus haute version disponible, SNAPSHOT comprises. Pendant la collecte, il lit aussi le pom de **chaque** version comprise dans la plage. Conséquences :

1. **Les SNAPSHOT Lutece 8 publiées récemment sont sélectionnées.** Par exemple, `plugin-crmclient:[2.0.2,)` se résolvait en `3.0.0-SNAPSHOT` (v8), qui exige `library-httpaccess ≥ 4.0.1`, alors que `library-notifygru` impose `< 3.9.9`. Résultat : `Could not resolve version conflict` sur **rendezvous**, et des libs v8 embarquées sans erreur dans **serviceez**.
2. **De très vieilles versions sont lues** (`plugin-solr 3.1.x`, `lutece-core 3.1.2`). Elles référencent des SNAPSHOT qui n'existent plus, via des dépôts `http://` que Maven bloque depuis la 3.8.1. Résultat : erreurs `Blocked mirror` sur **rendezvous** et **participez**.

Déclarer une dépendance directement dans notre pom ne suffit pas : la déclaration la plus proche fixe bien la version retenue, mais Maven parcourt quand même les plages transitives. Une exclusion ne vaut que pour une seule arête du graphe. Le seul mécanisme qui remplace la version d'une dépendance transitive **avant** la résolution, plage comprise, est le `dependencyManagement`.

## Correctifs appliqués dans `pom.xml`

- **Un `dependencyManagement` par profil** (`rendezvous`, `participez`, `serviceez`). Il fige chaque dépendance atteinte par une plage ouverte, ainsi que les SNAPSHOT tirées par des plages bornées. Les versions viennent des propriétés `<properties>` du pom.
- **Nouvelles propriétés :** `library.crmclient.version`, `library.identitystore.version`, `plugin.crmclient.version` et `jjwt.version`.
- **Correction des exclusions de `module-workflow-notifygru-alert` :** le `groupId` était `fr.paris.lutece` au lieu de `fr.paris.lutece.plugins`, donc les exclusions ne s'appliquaient pas.
- **Attention au `type` :** le `dependencyManagement` ne s'applique que si le `type` correspond à celui du pom qui déclare la dépendance (`jar`, `lutece-plugin` ou `lutece-core`). `plugin-elasticdata` a deux entrées dans rendezvous pour cette raison.

## Synthèse

| Profil | Plages ouvertes | Figées | Libs v8 embarquées | SNAPSHOT résolues | Pins |
|---|---|---|---|---|---|
| rendezvous | 46 | 46 | 0 | 4 (volontaires) | 31 |
| participez | 38 | 38 | 0 | 4 (volontaires) | 25 |
| serviceez | 19 | 19 | 0 | 4 (volontaires) | 18 |

Les 4 SNAPSHOT restantes sont déclarées explicitement dans notre pom, et elles n'existent qu'en SNAPSHOT : `site-theme-citelibre` / `library-theme-citelibre` 1.1.2-SNAPSHOT, `plugin-adminauthenticationoauth2` 1.0.0-SNAPSHOT et `module-workflow-notifygru-alert` 2.3.0-SNAPSHOT.

**Avant les correctifs :**

- **rendezvous :** build en échec, sur un conflit httpaccess puis sur des SNAPSHOT absentes. Une fois le build réparé, il embarquait encore `library-identitystore 4.0.0-SNAPSHOT` et `library-jwt 3.0.1-SNAPSHOT` (v8).
- **participez :** build en échec (SNAPSHOT absentes, via `lutece-core`).
- **serviceez :** le build passait, mais le war embarquait `library-httpaccess 4.0.1-SNAPSHOT`, `library-jwt 3.0.1-SNAPSHOT`, `library-signrequest 4.0.1-SNAPSHOT` et `library-core-utils 1.0.0` (v8), plus `lutece-core 7.1.10-SNAPSHOT`. **Son contenu a changé** : alignement sur `lutece-core 7.1.7-beta-01`, Spring 5.3.30, httpclient5 5.5.1 et jjwt 0.13.0. À valider au runtime.

## Profil `rendezvous`

Toutes les plages ci-dessous sont neutralisées par le `dependencyManagement` du profil. La colonne « Dernière v8 dispo » donne la version que Maven prendrait sans pin.

| Dépendance | Plages déclarées | Figée à | Dernière v8 dispo | Chemins depuis notre pom |
|---|---|---|---|---|
| `jjwt` | `[0.9.1,)` | 0.13.0 | - | `library-signrequest > library-jwt` |
| `library-elastic` | `[1.1.0,)` | 1.1.2 | 2.0.1-SNAPSHOT | `plugin-elasticdata` |
| `library-httpaccess` | `[2.2.9,)` `[2.4.1,)` `[2.6.0,)` `[3.0.0-SNAPSHOT,)` | 3.0.4-beta-02 | 4.0.1-beta-01 | `module-workflow-appointment > plugin-crmclient > library-crmclient`<br>`module-appointmentgru > library-identitystore`<br>`library-elastic`<br>`plugin-kibana`<br>`module-mylutece-oauth2`<br>`plugin-address`<br>`plugin-oauth2` |
| `library-identitystore` | `[2.0.5-SNAPSHOT,)` | 2.0.6 | 4.0.0-SNAPSHOT | `module-appointmentgru` |
| `library-jwt` | `[1.0.0,)` | 2.0.2 | 3.0.1-SNAPSHOT | `library-signrequest` |
| `library-rbac-api` | `[0.0.1,)` | 1.0.0 | 2.0.1-SNAPSHOT | `lutece-core > library-workflow-core` |
| `library-signrequest` | `[2.0.5,)` | 3.0.1 | 4.0.1-SNAPSHOT | `plugin-rest` |
| `library-user-api` | `[1.0.1,)` | 1.0.1 | 2.0.1-SNAPSHOT | `lutece-core > library-workflow-core` |
| `library-workgroup-api` | `[0.0.1,)` | 1.0.0 | 2.0.1-SNAPSHOT | `lutece-core > library-workflow-core` |
| `lutece-core` | `[3.0.0,)` `[5.0.0,)` `[7.0.0-RC-06,)` `[7.0.0,)` `[7.0.2,)` `[7.0.4,)` `[7.0.10,)` | 7.1.7-beta-01 | 8.0.2-beta-03 | `module-workflow-appointment > plugin-crmclient > library-crmclient`<br>`plugin-matomo`<br>`plugin-swaggerui`<br>`module-appointment-alert`<br>`module-appointment-filling`<br>`site-theme-citelibre > library-theme-citelibre`<br>`plugin-rest`<br>`plugin-leaflet`<br>`plugin-captcha`<br>`plugin-kibana`<br>`plugin-elasticdata`<br>`plugin-address`<br>`module-elasticdata-appointment`<br>`plugin-appointment`<br>`plugin-mylutece`<br>`module-appointment-desk`<br>`plugin-solr`<br>`plugin-mydashboard`<br>`module-notifygru-appointment`<br>`module-appointmentgru`<br>`module-appointment-management` |
| `module-appointmentgru` | `[2.0.5,)` | 2.0.6 | 3.0.0-SNAPSHOT | `module-notifygru-appointment` |
| `plugin-address` | `[1.1.0,)` | 1.1.0 | 2.0.1-beta-01 | `module-address-autocomplete` |
| `plugin-appointment` | `[3.0.0-SNAPSHOT,)` `[3.0.0,)` `[3.0.1-SNAPSHOT,)` `[3.0.1,)` | 3.0.8 | 4.0.0-beta-01 | `module-workflow-appointment`<br>`module-appointment-alert`<br>`module-appointment-filling`<br>`module-notifygru-appointment`<br>`module-elasticdata-appointment`<br>`module-appointmentgru`<br>`module-appointment-mydashboard`<br>`module-appointment-leaflet`<br>`module-appointment-solr`<br>`module-appointment-management`<br>`module-appointment-desk` |
| `plugin-captcha` | `[2.2.0,)` | 2.2.0 | 3.0.1-SNAPSHOT | `module-captcha-jcaptcha` |
| `plugin-crmclient` | `[2.0.2,)` | 2.1.3 | 3.0.0-SNAPSHOT | `module-workflow-appointment` |
| `plugin-elasticdata` | `[2.0.0,)` `[2.1.0,)` | 2.1.1 | 3.0.1-SNAPSHOT | `module-elasticdata-appointment`<br>`plugin-kibana` |
| `plugin-filegenerator` | `[2.1.4-SNAPSHOT,)` | 2.1.6 | 3.0.1-beta-01 | `plugin-appointment` |
| `plugin-genericattributes` | `[1.0.0-SNAPSHOT,)` `[2.1.1,)` | 2.4.8 | 3.0.2-beta-01 | `module-genericattributes-googlemaps`<br>`plugin-appointment` |
| `plugin-leaflet` | `[1.0.0,)` `[1.0.4,)` | 1.0.4 | 2.0.1-SNAPSHOT | `module-appointment-leaflet`<br>`plugin-solr` |
| `plugin-modulenotifygrumappingmanager` | `[2.0.1,)` `[2.0.2-SNAPSHOT,)` | 2.0.3 | 3.0.1-SNAPSHOT | `module-notifygru-appointment`<br>`module-appointmentgru` |
| `plugin-mydashboard` | `[1.3.0-SNAPSHOT,)` | 1.3.0 | 2.0.0-beta-01 | `module-appointment-mydashboard` |
| `plugin-mylutece` | `[4.0.4-SNAPSHOT,)` | 4.0.5 | 5.0.1-beta-01 | `module-mylutece-oauth2` |
| `plugin-oauth2` | `[1.1.0,)` | 1.1.2 | 3.0.1-beta-01 | `module-mylutece-oauth2` |
| `plugin-rest` | `[3.1.1,)` `[3.2.0,)` | 3.2.0 | 4.0.1-beta-01 | `plugin-leaflet`<br>`plugin-address` |
| `plugin-solr` | `[3.1.0,)` `[3.1.1,)` | 4.0.5 | 5.0.2-SNAPSHOT | `module-appointment-solr`<br>`module-appointment-solrsearchapp` |
| `plugin-workflow` | `[4.1.1,)` `[5.3.0,)` `[6.0.0,)` | 6.0.9-beta-01 | 7.0.2-beta-01 | `module-appointment-alert`<br>`module-notifygru-appointment`<br>`module-workflow-appointment` |

## Profil `participez`

Toutes les plages ci-dessous sont neutralisées par le `dependencyManagement` du profil. La colonne « Dernière v8 dispo » donne la version que Maven prendrait sans pin.

| Dépendance | Plages déclarées | Figée à | Dernière v8 dispo | Chemins depuis notre pom |
|---|---|---|---|---|
| `jjwt` | `[0.9.1,)` | 0.13.0 | - | `library-jwt` |
| `library-archive` | `[1.0.0-SNAPSHOT,)` | 1.0.0 | - | `plugin-archive` |
| `library-elastic` | `[1.1.0,)` | 1.1.2 | 2.0.1-SNAPSHOT | `plugin-elasticdata` |
| `library-httpaccess` | `[2.6.0,)` `[3.0.0-SNAPSHOT,)` | 3.0.4-beta-02 | 4.0.1-beta-01 | `library-elastic`<br>`plugin-kibana`<br>`module-mylutece-oauth2`<br>`plugin-address`<br>`plugin-oauth2` |
| `library-jwt` | `[1.0.0,)` | 2.0.2 | 3.0.1-SNAPSHOT | `library-signrequest` |
| `library-rbac-api` | `[0.0.1,)` | 1.0.0 | 2.0.1-SNAPSHOT | `library-workflow-core` |
| `library-signrequest` | `[2.0.5,)` | 3.0.1 | 4.0.1-SNAPSHOT | `plugin-rest` |
| `library-user-api` | `[1.0.1,)` | 1.0.1 | 2.0.1-SNAPSHOT | `library-workflow-core` |
| `library-workflow-core` | `[3.0.6,)` | 3.0.6 | 4.0.2-beta-02 | `module-workflow-formstopdf` |
| `library-workgroup-api` | `[0.0.1,)` | 1.0.0 | 2.0.1-SNAPSHOT | `library-workflow-core` |
| `lutece-core` | `[3.0.2-SNAPSHOT,)` `[5.0.0,)` `[6.0.0,)` `[6.2.0,)` `[7.0.0-RC-01,)` `[7.0.0,)` `[7.0.2,)` `[7.0.4,)` | 7.1.7-beta-01 | 8.0.2-beta-03 | `plugin-archive`<br>`plugin-matomo`<br>`module-forms-multiviewmapleaflet`<br>`plugin-seo`<br>`module-workflow-unittree-userassignment`<br>`site-theme-citelibre > library-theme-citelibre`<br>`plugin-rest`<br>`plugin-leaflet`<br>`plugin-captcha`<br>`plugin-kibana`<br>`plugin-elasticdata`<br>`plugin-html`<br>`module-forms-template`<br>`plugin-address`<br>`module-forms-userassignment`<br>`plugin-mylutece`<br>`plugin-solr`<br>`plugin-htmltopdf` |
| `module-workflow-unittree` | `[1.0.2,)` | 2.1.2 | 3.0.2-SNAPSHOT | `module-workflow-unittree-userassignment` |
| `module-workflow-userassignment` | `[1.0.0,)` | 2.1.3 | 3.0.1-beta-01 | `module-workflow-unittree-userassignment` |
| `plugin-address` | `[1.1.0,)` | 1.1.0 | 2.0.1-beta-01 | `module-address-autocomplete` |
| `plugin-captcha` | `[2.2.0,)` | 2.2.0 | 3.0.1-SNAPSHOT | `module-captcha-jcaptcha` |
| `plugin-elasticdata` | `[2.1.0,)` | 2.1.1 | 3.0.1-SNAPSHOT | `plugin-kibana` |
| `plugin-forms` | `[1.0.0,)` `[2.0.0,)` `[2.1.0,)` `[2.4.2-SNAPSHOT,)` | 3.1.4-beta-02 | 4.0.2-beta-03 | `module-forms-multiviewmapleaflet`<br>`module-forms-documentproducer`<br>`module-forms-userassignment`<br>`module-forms-template` |
| `plugin-genericattributes` | `[1.0.0-SNAPSHOT,)` | 2.4.8 | 3.0.2-beta-01 | `module-genericattributes-openstreetmap` |
| `plugin-leaflet` | `[1.0.0,)` `[1.0.4,)` | 1.0.4 | 2.0.1-SNAPSHOT | `module-forms-multiviewmapleaflet`<br>`plugin-solr` |
| `plugin-mylutece` | `[4.0.4-SNAPSHOT,)` | 4.0.5 | 5.0.1-beta-01 | `module-mylutece-oauth2` |
| `plugin-oauth2` | `[1.1.0,)` | 1.1.2 | 3.0.1-beta-01 | `module-mylutece-oauth2` |
| `plugin-regularexpression` | `[4.0.0,)` | 4.0.3 | 5.0.1-beta-01 | `module-forms-userassignment` |
| `plugin-rest` | `[3.1.1,)` `[3.2.0,)` | 3.2.0 | 4.0.1-beta-01 | `plugin-leaflet`<br>`plugin-address` |
| `plugin-unittree` | `[2.1.5,)` | 3.1.6-beta-01 | 4.0.1-beta-01 | `module-workflow-unittree-userassignment` |
| `plugin-userassignment` | `[1.0.0,)` | 1.0.3 | 2.0.1-SNAPSHOT | `module-forms-userassignment`<br>`module-workflow-unittree-userassignment` |

## Profil `serviceez`

Toutes les plages ci-dessous sont neutralisées par le `dependencyManagement` du profil. La colonne « Dernière v8 dispo » donne la version que Maven prendrait sans pin.

| Dépendance | Plages déclarées | Figée à | Dernière v8 dispo | Chemins depuis notre pom |
|---|---|---|---|---|
| `jjwt` | `[0.9.1,)` | 0.13.0 | - | `plugin-rest > library-signrequest > library-jwt` |
| `library-elastic` | `[1.1.0,)` | 1.1.2 | 2.0.1-SNAPSHOT | `plugin-elasticdata` |
| `library-httpaccess` | `[2.6.0,)` `[3.0.0-SNAPSHOT,)` | 3.0.4-beta-02 | 4.0.1-beta-01 | `library-elastic`<br>`plugin-kibana`<br>`module-mylutece-oauth2`<br>`plugin-oauth2` |
| `library-jwt` | `[1.0.0,)` | 2.0.2 | 3.0.1-SNAPSHOT | `plugin-rest > library-signrequest` |
| `library-rbac-api` | `[0.0.1,)` | 1.0.0 | 2.0.1-SNAPSHOT | `plugin-rest > lutece-core > library-workflow-core` |
| `library-signrequest` | `[2.0.5,)` | 3.0.1 | 4.0.1-SNAPSHOT | `plugin-rest` |
| `library-user-api` | `[1.0.1,)` | 1.0.1 | 2.0.1-SNAPSHOT | `plugin-rest > lutece-core > library-workflow-core` |
| `library-workgroup-api` | `[0.0.1,)` | 1.0.0 | 2.0.1-SNAPSHOT | `plugin-rest > lutece-core > library-workflow-core` |
| `lutece-core` | `[5.0.0,)` `[7.0.0,)` `[7.0.2,)` `[7.0.4,)` | 7.1.7-beta-01 | 8.0.2-beta-03 | `plugin-matomo`<br>`site-theme-citelibre > library-theme-citelibre`<br>`plugin-rest`<br>`plugin-leaflet`<br>`plugin-captcha`<br>`plugin-kibana`<br>`plugin-elasticdata`<br>`plugin-mylutece`<br>`plugin-solr` |
| `plugin-captcha` | `[2.2.0,)` | 2.2.0 | 3.0.1-SNAPSHOT | `module-captcha-jcaptcha` |
| `plugin-elasticdata` | `[2.1.0,)` | 2.1.1 | 3.0.1-SNAPSHOT | `plugin-kibana` |
| `plugin-leaflet` | `[1.0.4,)` | 1.0.4 | 2.0.1-SNAPSHOT | `plugin-solr` |
| `plugin-mylutece` | `[4.0.4-SNAPSHOT,)` | 4.0.5 | 5.0.1-beta-01 | `module-mylutece-oauth2` |
| `plugin-oauth2` | `[1.1.0,)` | 1.1.2 | 3.0.1-beta-01 | `module-mylutece-oauth2` |
| `plugin-rest` | `[3.1.1,)` | 3.2.0 | 4.0.1-beta-01 | `plugin-leaflet` |

## Limites

- **Graphe final uniquement :** le rapport ne couvre que les dépendances retenues dans le graphe final. Les plages déclarées dans des versions parcourues puis écartées n'y figurent pas.
- **Un chemin par module :** quand un module apparaît plusieurs fois dans l'arbre, un seul chemin est listé.
- **Plages bornées :** celles qui ne visent pas une dépendance figée (`[x,1.9.9)`) résolvent encore vers la plus haute version de la même majeure. Il n'y a pas de risque v8, mais le build n'est pas totalement reproductible.
- **Tant que `luteceSnapshot` est actif**, chaque nouvelle dépendance ajoutée à un profil doit être vérifiée avec la procédure ci-dessous.

## Vérifier un profil

```bash
# plages d'origine des dépendances figées : « version managed from [x,) »
mvn dependency:tree -Dverbose -Passembly,<profil>
# versions effectivement embarquées (repérer les SNAPSHOT et les majeures v8)
mvn dependency:list -Passembly,<profil>
```
