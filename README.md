# README #

### What is this repository for? ###

* Drawing Board Demo Application
* Build a simple server & frontend presenting a user with a 20x20 grid of squares the user can "draw" on to create a simple design.
* Demo for this application (http://akshathabhat.co.in/)

### How do I get set up? ###

## Summary of set up ##

* Rails 5.2.0
* Ruby 2.5.1

## Dependencies ##

* Redis
* Pg

## Database configuration ##

* rake db:create RAILS_ENV=production
* rake db:migrate RAILS_ENV=production
* rake db:seed RAILS_ENV=production
* to start server for action cable execute following command
    ./bin/cable


## How to run tests ##

* rake db:create RAILS_ENV=test
* rake db:migrate RAILS_ENV=test
* rake db:seed RAILS_ENV=test
* rspec --format documentation

## Deployment instructions ##

* rake assets:precompile RAILS_ENV=production
