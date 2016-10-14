#!/usr/bin/env bash

bin/rake db:setup RAILS_ENV=development
bin/rake db:migrate RAILS_ENV=development

bin/bundle exec rails s RAILS_ENV=development