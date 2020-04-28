#!/bin/sh
set -eu

PUSH_TO_BRANCH="$INPUT_PUSH_TO_BRANCH"
BEFORE_CMD="$INPUT_BEFORE_CMD"
AFTER_CMD="$INPUT_AFTER_CMD"

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "Set the GITHUB_TOKEN env variable"
  exit 1
fi

if [[ -z "$PUSH_TO_BRANCH" ]]; then
  echo "Set the PUSH_TO_BRANCH Variable"
  exit 1
fi

# Update Github Config.
git config --global user.email "githubactionbot+apigen@gmail.com" && git config --global user.name "ApiGen Github Bot"

# Custom Command Option
if [[ ! -z "$BEFORE_CMD" ]]; then
  echo "Running BEFORE_CMD"
  eval "$BEFORE_CMD"
fi

cd ../
echo "Creating Required TEMP DIR"
mkdir apigen
mkdir apigen_ouput

echo "Installing Composer"
cd apigen
#curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
echo '{ "require" : { "apigen/apigen" : "4.1.2" } }' >>composer.json
composer update
chmod +x ./vendor/bin/apigen

echo "Running ApiGen"
./vendor/bin/apigen generate -s $GITHUB_WORKSPACE --destination ../apigen_ouput

cd $GITHUB_WORKSPACE
# Custom Command Option
if [[ ! -z "$AFTER_CMD" ]]; then
  echo "Running AFTER_CMD"
  eval "$AFTER_CMD"
fi

echo "Validating Output"
cd ../apigen_ouput/
ls -la

echo "Pushing To Github"
git init
git remote add origin "https://x-access-token:$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY"
git add .
git commit -m "ApiGen Code Docs Regenerated"
git push origin "master:${PUSH_TO_BRANCH}" -f
