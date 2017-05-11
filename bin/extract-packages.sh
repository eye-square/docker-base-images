#! /bin/bash
set -e

FILE_ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
PROJECT_ROOT=$FILE_ROOT/..
: ${SOURCE_PATH:=$PROJECT_ROOT/../in-context-testing}

PathsOfPackages[0]='/client/apps/browser-hub'
PathsOfPackages[1]='/client/apps/chrome-extension'
PathsOfPackages[2]='/client/apps/firefox-extension'
PathsOfPackages[3]='/client/apps/firefox-extension/lib'
PathsOfPackages[4]='/client/apps/tracking-proxy'

PathsOfPackages[5]='/client/lib/extension'
PathsOfPackages[6]='/client/lib/messaging'
PathsOfPackages[7]='/client/lib/metrics-collection'
PathsOfPackages[8]='/client/lib/mobile-web-shell'
PathsOfPackages[9]='/client/lib/shell'
PathsOfPackages[10]='/client/lib/utils'
PathsOfPackages[11]='/client/lib/web-tracking'

PathsOfPackages[12]='/context/lib/iphone-inline-video'
PathsOfPackages[13]='/context/lib/jump.js'
PathsOfPackages[14]='/context/lib/utils'

PathsOfPackages[15]='/context/apps/facebook'
PathsOfPackages[16]='/context/apps/youtube'
# PathsOfPackages[17]='/context/apps/instagram'
# PathsOfPackages[18]='/context/apps/snapchat'
PathsOfPackages[19]='/context/apps/hulu'

PathsOfPackages[20]='/context/scripts/lib/e2-timer-api'
PathsOfPackages[21]='/context/scripts/lib/facebook-login-checker'
PathsOfPackages[22]='/context/scripts/lib/instagram-personal'
PathsOfPackages[23]='/context/scripts/lib/twitter-personal-desktop'
PathsOfPackages[24]='/context/scripts/lib/twitter-personal-mobile'
PathsOfPackages[25]='/context/scripts/lib/youtube-channel-replacement'
PathsOfPackages[26]='/context/scripts/lib/youtube-personal'

PathsOfPackages[27]='/server/lib/mongoose-model'
PathsOfPackages[28]='/server/lib/utils'

PathsOfPackages[29]='/server/apps/logger'
PathsOfPackages[30]='/server/apps/manager'
PathsOfPackages[31]='/server/apps/projects-api'
PathsOfPackages[32]='/server/apps/recording-scheduler'
PathsOfPackages[33]='/server/apps/statics'

PathsOfPackages[34]='/lib/utils'
PathsOfPackages[35]='/lib/enumns'
PathsOfPackages[36]='/lib/logging'


function copyFromSource {
  for i in "${PathsOfPackages[@]}"
  do
    mkdir -p ${PROJECT_ROOT}/data${i}
    cp ${SOURCE_PATH}${i}/package.json ${PROJECT_ROOT}/data${i}/package.json
    PACKAGE=${PROJECT_ROOT}/data${i}/package.json ${PROJECT_ROOT}/bin/remove-local-libs.sh
    # cp ${SOURCE_PATH}${i}/yarn.lock ${PROJECT_ROOT}/data${i}/yarn.lock
  done
}

function install {
  for i in "${PathsOfPackages[@]}"
  do
    echo $i
    cd ${PROJECT_ROOT}/data${i} && yarn install || true && rm -f yarn.lock  && rm -f  yarn-error.log && rm -f package.json
  done
}

case $1 in
    copy)
    copyFromSource
    exit
    ;;
    *)
    install
    exit
    ;;
esac
