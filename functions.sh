BLUE=$(tput setaf 111)
PURPLE=$(tput setaf 135)
RED=$(tput setaf 196)
GREEN=$(tput setaf 40)
YELLOW=$(tput setaf 122)
WHITE=$(tput setaf 255)

log () {
 echo -e "${BLUE}@collab \t${WHITE}$1 \t${PURPLE}$2${WHITE}"
}

log_error () {
 echo -e "${RED}ERROR \t${YELLOW}$1 \t${WHITE}$2"
 exit -1
}

log_info () {
 echo -e "${BLUE}@collab \t${PURPLE}$1 \t${WHITE}$2"
}

log_success () {
 echo -e "${BLUE}@collab \t${GREEN}$1 \t${WHITE}$2"
}

fn_exists() { 
  type $1 &>/dev/null && echo 1 || echo 0
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  PLATFORM="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  PLATFORM="mac"
else
  log_error "Unsupported platform detected" $OSTYPE
fi
