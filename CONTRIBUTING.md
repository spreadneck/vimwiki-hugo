# Contributing Guidelines

## How to Propose Changes

- Fork this repository and create a feature branch (use `feat/`, `fix/` etc.)
- Follow code style and commit guidelines.
- Run linters via Makefile before opening a PR.
- Document significant changes in the `CHANGELOG.md`.

## Maintainer Release Checklist

1. **Update Your Local Main & Review CI**

   - Ensure your local `main` branch is up to date (pull from `origin`).
   - Check that all CI workflows are passing on your branch and the latest `main`.

2. **Bump the Project Version**

   - Run the version bump script with your target major.minor:
     ```sh
     ./bin/bump_version.sh 0.1
     # You will be prompted for release notes. End input with a blank line.
     ```
   - (Alternatively, provide notes inline: `-m "Summary of this release"` or use `./bin/edit_changelog_entry.sh` for editor-based notes.)

3. **Push Version, Tags, and Latest**

   - The script will commit, tag, and push automatically.
   - Confirm the latest tag and version tag are both updated on GitHub:
     - https://github.com/<USERNAME>/<REPOSITORY>/tags

4. **Verify Automated Release**

   - The [Release Automation Workflow](https://github.com/<USERNAME>/<REPOSITORY>/actions/workflows/release.yml) runs on each new tag:
     - Builds the Hugo site for production.
     - Extracts release notes from `CHANGELOG.md`.
     - Publishes a new [GitHub Release](https://github.com/<USERNAME>/<REPOSITORY>/releases).
     - Deploys the built site to GitHub Pages.

5. **Check Deployment**

   - Visit your live site to verify correct publishing:
     - https://<USERNAME>.github.io/<REPOSITORY>/

6. **Post-Release**
   - Update documentation or site links if features or URLs have changed.
   - Announce the release if appropriate (in README.md, “Posts”, or offsite community channels).

---

## Additional Project Docs & Links

- [Project README](./README.md)
- [Change Log](./CHANGELOG.md)
- [Code of Conduct](./CODE_OF_CONDUCT.md)
- [Release Automation Workflow](https://github.com/<USERNAME>/<REPOSITORY>/actions/workflows/release.yml)
- [Live Site](https://<USERNAME>.github.io/<REPOSITORY>/)
- [Contributing Guidelines (this page)](./CONTRIBUTING.md)
