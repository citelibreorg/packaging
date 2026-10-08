# AGENTS.md

## What this repo is

CiteLibre packaging: assembles Lutece core + plugins (from the `dev.lutece.paris.fr`
repositories) into three deployable services — `citelibre-rendezvous`,
`citelibre-serviceez`, `citelibre-participez` — and builds their Docker images (Jib).
There is **no application source code**: no Java files, nothing here compiles app code.
Changes are pom profiles, Lutece webapp configuration (`webapp/WEB-INF`), Tomcat runtime
configuration, and documentation.

CiteLibre is split into three sibling repositories (usually cloned side by side):

- `packaging` (this one): Maven assembly + Docker image build.
- `demo`: Docker Compose stack (shared platform + one compose per service, `.env`, SQL
  init scripts) and Cypress e2e tests. Running an image built here happens there.
- `ops`: Kubernetes deployment (Bundlebee descriptors, Minikube scripts).

Do not add compose files, SQL init scripts, k8s descriptors or e2e tests here.

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
  When bumping it, also bump `CITELIBRE_IMAGE_VERSION` in the app's `.env` of the `demo`
  repository (and the image version used by `ops`) — the serviceez `.env` in `demo`
  (1.0.9) is stale vs its pom profile (1.0.2).
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

## Running the images

Local run (docker compose, platform first) and e2e tests live in the `demo` repository,
Kubernetes deployment in the `ops` repository. See their `AGENTS.md`.

## Other

- `citelibre-documentation/` is a standalone Maven project (yupiik-tools minisite /
  AsciiDoc for citelibre.org), not part of the root build.
- Per-app layout: `webapp/` (Lutece webapp, incl. `WEB-INF` config), `runtime/conf/`
  (Tomcat `context.xml`/`server.xml` overrides), `runtime/descriptors/tomcat.xml`
  (assembly descriptor).
- Docker Hub publishing is driven by `docker.yml` on tags matching `*/x.y.z.w`
  (Jib push) — currently broken because of the missing `./mvnw`.

## Community files

- `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md` and `SECURITY.md` are identical copies in
  `packaging`, `demo`, `ops` and the org `.github` repository (org-wide default). When
  changing one, apply the same change to all four copies. Keep their links relative
  (`CODE_OF_CONDUCT.md`, `SECURITY.md`) or absolute and repo-independent.
- Issue and pull request templates live only in the org `.github` repository; do not add
  a `.github/ISSUE_TEMPLATE/` here, it would replace all the org templates.
