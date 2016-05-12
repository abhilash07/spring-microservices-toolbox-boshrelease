#!/bin/bash
set -e
export PATH=$PATH:/var/vcap/packages/cli


CF_API_URL='<%= p("cf.api_url") %>'
CF_USERNAME='<%= p("cf.username") %>'
CF_PASSWORD='<%= p("cf.password") %>'
CF_ORG='<%= p("cf.org") %>'
CF_DEFAULT_SPACE='<%= p("cf.default_space") %>'
CF_TARGET_SPACE='<%= p("cf.target_space") %>'

cf login -a $CF_API_URL  -u $CF_USERNAME -p CF_PASSWORD  -o $CF_ORG -s $CF_DEFAULT_SPACE --skip-ssl-validation


