#!/bin/sh
set -eu
YES_VAL="yes"
PUSH_TO_BRANCH="$INPUT_PUSH_TO_BRANCH"
BEFORE_CMD="$INPUT_BEFORE_CMD"
AFTER_CMD="$INPUT_AFTER_CMD"
AUTO_PUSH="$INPUT_AUTO_PUSH"
OUTPUT_FOLDER="$INPUT_OUTPUT_FOLDER"
SOURCE_FOLDER="$INPUT_SOURCE_FOLDER"
FULL_SOURCE_FOLDER="$GITHUB_WORKSPACE/$SOURCE_FOLDER"
echo " "

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "🚩 Set the GITHUB_TOKEN env variable"
  exit 1
fi

if [[ -z "$PUSH_TO_BRANCH" ]]; then
  echo "🚩 Set the PUSH_TO_BRANCH Variable"
  exit 1
fi

if [ -z "$SOURCE_FOLDER" ]; then
  SOURCE_FOLDER=""
fi

if [[ ! -z "$BEFORE_CMD" ]]; then
  echo "⚡️ Running BEFORE_CMD"
  echo "---------------------------------------------------------------"
  eval "$BEFORE_CMD"
  echo "---------------------------------------------------------------"
  echo " "
fi

cd ../

echo " "
echo "------------------------------------"
echo "🏗 Doing Groud Work"
mkdir apigen
mkdir apigen_ouput
cd apigen

echo "✨ Installing Composer"
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer >>/dev/null 2>&1
echo "✨ Installing ApiGen"
#echo "//////////////////////////////"
#echo " "
echo '{ "require" : { "apigen/apigen" : "4.1.2" } }' >>composer.json
composer update >>/dev/null 2>&1
chmod +x ./vendor/bin/apigen
#echo " "
#echo "//////////////////////////////"
#echo " "
#echo "------------------------------------"
echo "🚀 Running ApiGen"
echo "--- 📈 Source Folder : $FULL_SOURCE_FOLDER"
#echo "------------------------------------"
echo " "
./vendor/bin/apigen generate -s $FULL_SOURCE_FOLDER --destination ../apigen_ouput
cd $GITHUB_WORKSPACE

if [[ ! -z "$AFTER_CMD" ]]; then
  echo "⚡️Running AFTER_CMD"
  echo "---------------------------------------------------------------"
  eval "$AFTER_CMD"
  echo "---------------------------------------------------------------"
  echo " "
fi

echo " "
echo "------------------------------------"
echo "✅ Validating Output"
echo " "
cd ../apigen_ouput/ && ls -lah
echo " "
echo "------------------------------------"
echo " "
echo " "

if [ "$AUTO_PUSH" == "$YES_VAL" ]; then
  echo " "
  echo "🚚 Pushing To Github"
  echo " "
  git config --global user.email "githubactionbot+apigen@gmail.com" && git config --global user.name "ApiGen Github Bot"
  cd ../

  if [ -z "$(git ls-remote --heads https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git ${PUSH_TO_BRANCH})" ]; then
    git clone --quiet https://x-access-token:$GITHUB_TOKEN@github.com/${GITHUB_REPOSITORY}.git $PUSH_TO_BRANCH > /dev/null
    cd $PUSH_TO_BRANCH
    git checkout --orphan $PUSH_TO_BRANCH
    git rm -rf .
    echo "$GITHUB_REPOSITORY" > README.md
    git add README.md
    git commit -a -m "➕ Create $PUSH_TO_BRANCH Branch"
    git push origin $PUSH_TO_BRANCH
    cd ..
    echo "
🗃 $PUSH_TO_BRANCH Created
"
  else
    git clone --quiet --branch=$PUSH_TO_BRANCH https://x-access-token:$GITHUB_TOKEN@github.com/${GITHUB_REPOSITORY}.git $PUSH_TO_BRANCH > /dev/null
    echo "
👌 $PUSH_TO_BRANCH Cloned
"
  fi

  cp -r apigen_ouput/* $PUSH_TO_BRANCH/
  cd $PUSH_TO_BRANCH/

  if [[ "$(git status --porcelain)" != "" ]]; then
    git add .
    git commit -m "📖 #$GITHUB_RUN_NUMBER - ApiGen Code Docs Regenerated / ⚡ Triggered By $GITHUB_SHA"
    git push origin $PUSH_TO_BRANCH
    echo "
👌 Docs Published
"
  else
    echo "
✅ Nothing To Push
"
  fi

else
  cd $GITHUB_WORKSPACE
  cp -r ../apigen_ouput/* $OUTPUT_FOLDER
  cd $OUTPUT_FOLDER
  ls -lah
  rm -rf ../apigen_ouput
  echo "
✅ Docs Copied To $OUTPUT_FOLDER
"
fi
