#!/bin/sh    
REQUIREMENTS_FILE=requirements.txt
case "$1" in
  install)
    if [ ! -z "$2" ]; then
      case "$2" in
        --file | -f)
          if [ -z "$3" ]; then
            echo "Please provide a file name"
            exit 1
          fi
          if [ ! -e "$3" ]; then
            echo "File does not exist."
            exit 1
          fi
          REQUIREMENTS_FILE="$3"
        ;;
        *)
          echo "Invalid option: install $2"
          exit 1
        ;;
      esac
    fi
    xargs -a $REQUIREMENTS_FILE sudo dnf install -y
    ;;
  add)
    if [ -z "$2" ]; then
      echo "Please provide a dependency"
      exit 1
    fi
    DEPENDENCY="$2"
    if [ ! -z "$(grep "$DEPENDENCY" "$REQUIREMENTS_FILE")" ]; then
      echo "Dependency: $DEPENDENCY already in requirements"
      exit 1
    else
      echo $DEPENDENCY >> $REQUIREMENTS_FILE
      sudo dnf install -y $DEPENDENCY
      exit 0
    fi
  ;;
  remove)
    if [ -z "$2" ]; then
      echo "Please provide a dependency"
      exit 1
    fi
    DEPENDENCY="$2"
    if [ -z "$(grep "$DEPENDENCY" "$REQUIREMENTS_FILE")" ]; then
      echo "Dependency: $DEPENDENCY already in requirements"
      exit 1
    else
      sed -i "/\b$DEPENDENCY\b/d" $REQUIREMENTS_FILE
      exit 0
    fi
  ;;
  help)
    echo "install             : finds the requirements.txt file and installs the missing dependencies"
    echo "        --file | -f : overrides the dependency file on every command"
    echo ""
    echo "verify              : outputs which dependencies are not met"
    echo ""
    echo "add <dependency>    : adds the dependency to the requirements.txt and installs it"
    echo ""
    echo "remove <dependency> : removes the dependency from the requirements.txt file"
    echo ""
    echo "help                : removes the dependency from the requirements.txt file"
  ;;
  *)
    echo "Invalid option: $1"
    exit 1
  ;;
esac