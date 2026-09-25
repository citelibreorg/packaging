# AGENTS.md

## What this repo is

CiteLibre packaging: assembles Lutece core + plugins (from the `dev.lutece.paris.fr`
repositories) into three deployable services — `citelibre-rendezvous`,
`citelibre-serviceez`, `citelibre-participez` — plus a shared docker-compose platform,
Bundlebee/K8s deployment descriptors and Cypress e2e tests. There is **no application
source code**: no Java files, nothing here compiles app code. Changes are pom profiles,
Lutece webapp configuration (`webapp/WEB-INF`), SQL init scripts, docker/Bundlebee
descriptors, and documentation.

## Toolchain

- Maven 3.6.3 + Java 21 (Zulu). The enforcer plugin requires Maven ≥ 3.6 and Java 21;
  `.sdkmanrc` pins both (sdkman auto-env switches when enabled). CI uses Java 21 Zulu.
- **There is no `mvnw` wrapper in this repo.** Use `mvn`.
  (`.github/workflows/docker.yml` references `./mvnw` which does not exist — that
  workflow is a template, do not copy it as-is.)
- CI (`.github/workflows/maven.yml`) builds only the `rendezvous` profile.

## Build commands

```bash
# A profile is mandatory: packaging is lutece-site, there is no default profile
mvn package -Passembly,rendezvous         # also: serviceez, participez
mvn package -Passembly,rendezvous,docker  # + local docker image via Jib (no daemon needed)
```

- Output is the exploded dir `target/assembly/citelibre-<app>/apache-tomcat/`
  (assembly format is `dir` only — no tarball). Jib image:
  `citelibre/citelibre-<app>:<version>`.
- The per-profile `citelibre.packaging.version` in `pom.xml` is the app/image version.
  `CITELIBRE_IMAGE_VERSION` in each app's `docker/.env` must match it — the serviceez
  `.env` (1.0.9) is stale vs its pom profile (1.0.2).
- lutece-maven-plugin logs many `[ERROR] ... SQL files are not tagged for Liquibase ...`
  lines during site-assembly. This is expected noise; the build still ends SUCCESS.
- lutece-maven-plugin also reads local configuration from `~/lutece/conf/<artifactId>/`.
- A license check (BSD 2-Clause header) runs in the `validate` phase of every build.
  New `.java/.xml/.properties/.yaml` files need the header; `mvn license:format` fixes it.

## Dependencies — read `dependencies.md` first

Lutece plugins declare open version ranges (`[x,)`) and the `luteceSnapshot` repository
has snapshots enabled. Without pinning, Maven pulls Lutece 8 SNAPSHOTs (build failures)
or very old versions that no longer exist:

- Each app profile has a `dependencyManagement` block pinning every transitive open
  range. **When adding a dependency with an open range, also pin it in that profile's
  `dependencyManagement`** — a direct declaration alone does not stop Maven walking the
  transitive ranges, and an exclusion only covers one graph edge.
- The `type` in `dependencyManagement` must match the declaring pom
  (`jar`, `lutece-plugin`, `lutece-core`).
- Four SNAPSHOTs are intentional (themes, `plugin-adminauthenticationoauth2`,
  `module-workflow-notifygru-alert`, …) — do not "fix" them.
- Verify resolution with `mvn dependency:tree -Dverbose -Passembly,<profil>` and
  `mvn dependency:list -Passembly,<profil>`.

## Local stack (order matters)

1. `docker compose -f citelibre-platform/docker-compose.yml up -d` — shared
   infrastructure: MariaDB, Keycloak, Elasticsearch, Kibana, Solr, Matomo, httpd portal
   (port 80), Mailpit. Creates the named network `citelibre-network`.
2. `docker compose -f citelibre-rendezvous/docker/docker-compose.yml up` — app compose
   files declare `citelibre-network` as **external**, so they fail if the platform is
   not up first. The image must be built locally first (Jib, above).
- All compose files take their variables from the `.env` next to them (local dev
  credentials — never put real secrets there).
- DB bootstrap: shared `citelibre-common/sql/init_db.sh` + each app's `docker/sql/*.sql`
  (choose the auth provider SQL file that is mounted, not the commented one).
- Back office: `http://localhost/citelibre-rendezvous/jsp/admin/AdminMenu.jsp`
  (`admin@paris.fr` / `coucou`); front office: `/jsp/site/Portal.jsp`.

## Kubernetes deployment (Bundlebee)

- Descriptors: `deploy/bundlebee/` (`manifest.json` + `manifests/*.json`, alveolus
  `citelibre`). Apply: `mvn -e bundlebee:apply@k8s -Pbundlebee`; delete:
  `mvn -e bundlebee:delete@k8s -Pbundlebee`; dry-run + verbose: `-Dbundlebee.debug=true`.
  `deploy/0_install.sh` … `7_delete.sh` wrap minikube around these commands.
- Placeholders must be documented in
  `deploy/bundlebee/placeholders.descriptions.properties`: with `-Pbundlebee`, the
  `placeholder-extract` execution (`failOnInvalidDescription=true`) fails the build on
  an undocumented placeholder.

## E2E tests (Cypress)

- `tests/` is a standalone npm project, not part of the Maven build:
  `cd tests && npm install && npm run cy:common`.
- Requires the platform and the service under test to be running first (baseUrl is the
  rendezvous back office); login uses the local dev credentials.

## Other

- `citelibre-documentation/` is a standalone Maven project (yupiik-tools minisite /
  AsciiDoc for citelibre.org), not part of the root build.
- Per-app layout: `webapp/` (Lutece webapp, incl. `WEB-INF` config), `runtime/conf/`
  (Tomcat `context.xml`/`server.xml` overrides), `runtime/descriptors/tomcat.xml`
  (assembly descriptor), `docker/` (compose + `.env` + SQL).
- Docker Hub publishing is driven by `docker.yml` on tags matching `*/x.y.z.w`
  (Jib push) — currently broken because of the missing `./mvnw`.
