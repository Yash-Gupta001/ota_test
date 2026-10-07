#!/bin/bash
set -e
OLD=$(grep '^version:' pubspec.yaml | sed 's/version: //')
NAME=$(echo "$OLD" | cut -d'+' -f1)
BUILD=$(echo "$OLD" | cut -d'+' -f2)
NEW_BUILD=$((BUILD + 1))
NEW_VERSION="${NAME}+${NEW_BUILD}"
sed -i "s/^version: .*/version: $NEW_VERSION/" pubspec.yaml
echo "Bumped version from $OLD to $NEW_VERSION"
git config user.name "gitlab-ci[bot]"
git config user.email "gitlab-ci[bot]@noreply.gitlab.com"
git remote set-url origin "https://oauth2:${GITLAB_PUSH_TOKEN}@${CI_SERVER_HOST}/${CI_PROJECT_PATH}.git"
git add pubspec.yaml
git commit -m "chore: bump build number to ${NEW_VERSION} [skip ci]"
git push origin HEAD:${CI_COMMIT_REF_NAME}
