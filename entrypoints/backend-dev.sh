#!/bin/bash

rm -f /home/app/tmp/pids/server.pid
bundle install
bundle exec rails s -b 0.0.0.0 -p 80