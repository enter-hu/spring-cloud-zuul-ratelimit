#!/usr/bin/env bash

echo "Branch: $TRAVIS_BRANCH"
echo "Pull Request? $TRAVIS_PULL_REQUEST"
echo "Commit Message: $TRAVIS_COMMIT_MESSAGE"

if [[ "$TRAVIS_COMMIT_MESSAGE" == *"[ci deploy]"* ]]; then
  echo "RELEASE INITIATED"

  mvn --settings .ci/settings.xml clean deploy -DskipTests -Pdeploy-parent -N
  mvn --settings .ci/settings.xml -f spring-cloud-zuul-ratelimit-dependencies/pom.xml clean deploy -DskipTests -Pdeploy
  mvn --settings .ci/settings.xml -f spring-cloud-starter-zuul-ratelimit/pom.xml clean deploy -DskipTests -Pdeploy
  mvn --settings .ci/settings.xml -f spring-cloud-zuul-ratelimit-core/pom.xml clean deploy -DskipTests -Pdeploy

  echo "NEW VERSION RELEASED"
fi

echo "BUILD FINISHED"