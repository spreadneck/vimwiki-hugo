# 0.1 Release QA Checklist

## Pre-Release

- [ ] CI pipelines pass on `main` (build, lint, and test workflows)
- [ ] All shell, YAML, and Markdown scripts have linted cleanly
- [ ] Changelog is up-to-date with changes for this version
- [ ] Version in `VERSION` is new and correctly formatted
- [ ] `latest` tag will point to correct commit after release
- [ ] `README.md` and documentation are up-to-date and accurate
- [ ] LICENSE, CONTRIBUTING, and CODE_OF_CONDUCT files present and up-to-date
- [ ] No sensitive data, credentials, or unwanted files are present (scan project and `.gitignore`)
- [ ] All major internal/external links in docs and site are correct (no 404s)
- [ ] All CI/workflow badges are visible and accurate in README

## Release

- [ ] Run the version bump script:
      ./bin/bump_version.sh X.Y
