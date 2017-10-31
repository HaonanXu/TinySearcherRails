# README

This is a small version of TinySearch App based on Ruby on Rails (Ruby 2.3 and Rails 5.1)

* To run this App, Please:
  - Fork this Rep
  - git clone to the local
  - cd into the project folder
  - make sure the `docker-compose` is intalled
  - run: `docker-compose build` then
  - run: `docker-compose up` and after app is up
  - open another terminal run: `docker-compose run web rails db:setup`
  - then visiting `localhost:3000` to start
  - Tested with `docker-compose 1.16.1` on `Mac OS Sierra 10.12.6`/`Yosemite 10.10.5`, and `Ubuntu 16.04`
  - Seems not compartible with Windows, there is a setup issue with postgres on `docker toolbox` and `VitualBox` on Windows 10 home. First time using docker...
  - `haonanxu/tiny_searcher` is the remove image on DockHub

* Functions Implemented
  - Twitter key words search
  - User Register, Login, Logout, and password reset
  - User activity logging, System error logging
  - Try Luck to have a random search with Redis caching for efficiency
  - Unit tests with Rspec

* Design patterns used in the project:
  - Gateway pattern for the App's Search service:
    - Easily expanding for more search modules in future, such as: LCBO, Weather and so on. Sub-services will be developed in       their own class, so we can just chip in or plug out of them as we want.
    - Easy testing: since all the search sevices are separated we can wiring test for each class.
  - Chain of Responsibility pattern for Logging service:
    - Loggers are linked as a list
    - Just pass objects and params that needs to be logged to the logger handler and the event will be handled in the chain

