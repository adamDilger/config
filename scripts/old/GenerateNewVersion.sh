RED='\033[0;31m'
GREEN='\033[0;32m'
WHITE='\033[0m'

exit_program() {
  if [[ "$PWD" != */ResponsiveApp ]]; then
    cd ..;
  fi

  exit 0;
}

# this allows the script to be run from either the
# payg-frontend or the payg-frontend/ResponsiveApp directories
# the script is setup to run from the ResponsiveApp dir
if [[ "$PWD" != */ResponsiveApp ]]; then
  if [ "$(ls -l | grep ResponsiveApp)" != "" ]; then
    cd ResponsiveApp;
  fi

  if [[ "$PWD" != */ResponsiveApp ]]; then
    echo -e "Please run this from the ${GREEN}payg-frontend${WHITE} directory";
    exit 1;
  fi
fi

clear
echo "========================================================================="

CURRENT=$(grep version package.json | awk -F '"' '{print $4}')

confirm() {
  read -p "$1 (y,n): " CONFIRM

  if [ "$CONFIRM" != "y" ]; then
    echo "exiting..."
    exit_program
  fi
}

run_tests() {
  echo "Running tests..."

  #run npm test
  OUT=$(CI=true npm test -- --bail --colors 2>&1 | grep FAIL)

  if [ "$OUT" != "" ]; then
      # one ore more tests have failed
      echo "$OUT"
      exit_program
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

git add package.json
git commit -m "Version bump $VERSION"
git push
git tag "release/$VERSION"
git push --tags

exit_program
