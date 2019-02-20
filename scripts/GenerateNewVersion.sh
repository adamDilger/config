RED='\033[0;31m'
GREEN='\033[0;32m'
WHITE='\033[0m'

if [[ "$PWD" != */ResponsiveApp ]]; then
  echo -e "Please run this from the ${GREEN}payg-frontend/ResponsiveApp${WHITE} directory";
  exit 1;
fi

clear
echo "========================================================================="

CURRENT=$(grep version package.json | awk -F '"' '{print $4}')

confirm() {
  read -p "$1 (y,n): " CONFIRM

  if [ "$CONFIRM" != "y" ]; then
    echo "exiting..."
    exit 1;
  fi
}

run_tests() {
  echo "Running tests..."

  #run npm test
  OUT=$(CI=true npm test -- --bail --colors 2>&1 | grep FAIL)

  if [ "$OUT" != "" ]; then
      # one ore more tests have failed
      echo "$OUT"
      exit 1
  fi

  echo "Tests passed."
}

update_package_json_version() {
  sed -i "s/\"version\": \"\(.*\)\"/\"version\": \"$VERSION\"/" package.json
}

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

echo -e "You are currently on branch: ${GREEN}$(parse_git_branch)${WHITE}"
echo -e "Current version number is: ${GREEN}$CURRENT${WHITE}"
echo
read -p "Enter the new version number: " VERSION

echo
echo -e "You entered: ${RED}$VERSION${WHITE}"

confirm "Is this correct?"

run_tests

update_package_json_version

git diff

confirm "About to push these changes to master, proceed?"

git commit -am "Version bump $VERSION"
git push
git tag "release/$VERSION"
git push --tags

exit 0
