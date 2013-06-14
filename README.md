# median-price-rails

Welcome to median-price-rails. This is the server side of a (very) simple web app that uses RESTful principles. It was built for a prospective employer to show basic Ruby and web architecture skills. As this was built purely for pedagogical purposes, it omits crucial aspects of systems development, such as any notion of security.

This is deployed to [the Heroku platform](https://www.heroku.com/) at http://median-price.herokuapp.com. The [median-price-android](http://github.com/egarson/median-price-android) mobile client complements and integrates with this app using the Heroku host.

This was built using [Ruby on Rails](http://rubyonrails.org) 3.1.2, an MVC-based web framework that has pretty good support for [REST](http://en.wikipedia.org/wiki/Representational_state_transfer) out of the box (see below for more).

## What does it Do?

This application provides a service to calculate the median price paid for a given Item scoped on some set of attributes. For example, the median price paid for a 2005 BMW, or all 2005-2008 Fords, and so on. The idea is to provide the user with some notion of 'fair market value' for a used Vehicle, or some other item.

Again, this was built for pedagogical purposes, so attributes are not assigned dynamically by category, which could be one approach to reify this functionality in a 'real' application. That is to say, the notion of brand and year do not apply to the sale of all Items, which this system assumes.

### Examples

#### GET all items
  curl http://median-price.herokuapp.com/items.json

#### GET the median price for 2011-2012 Mercedes
  curl http://median-price.herokuapp.com/items/median.json?brand=merc&year=2011-2012

## Pragmatic REST

The flavor of REST as implemented by this application lies somewhere between Level 2 and 3 of the [Richardson Maturity Model](http://martinfowler.com/articles/richardsonMaturityModel.html). Rails takes a pragmatic approach to REST which 'out of the box' but cannot fully achieve [HATEOS](http://en.wikipedia.org/wiki/HATEOAS) nirvana without assistance from the programmer(!). To be fully Level 3, a relation would need to be set up with Item (such as Category, as per the above) with links returned in the payload to demonstrate **connectedness**, which is a core tenet of The RESTful Way (and indeed, the driver behind HATEOS).

Rails provides assistance with Level 3 via the *Location* HTTP header (after a successful POST, for example) but cannot grok the state of the application from the perspective of connected resources from there.

## Testing Notes

* [RSpec](http://rspec.info/) was used in preference to Test::Unit, mostly because it's what I've been using with Ruby for the last while.
* The tests are arguably a bit repetitive in order to make intent clear. I generall eschew the use of setup/teardown for this reason (with the exception to save time: fast tests trump intent).

## TODO

In no particular order, here are the next items I would have liked to implement:

* version the api: URIs should read something like, /median/v1/...
* implement NOT_MODIFIED/304 via ETags
* return something sensible on NOT_FOUND/404
* implement an example of FORBIDDEN/403 (PUT to /item/<id> with an initialized :paid field)
* and, add an administrative back-door to enable PUT to a sold item using a 'magic' header
* disallow both null year and brand
* add Allow header
* return a modicum of documentation from the root uri
* batching large results
* add performance/load tests, perhaps using [tsung](http://tsung.erlang-projects.org/): performance testing should be a [*first-class citizen*](http://www.thoughtworks.com/radar).

## High-Level Setup Guide

See [Rails Guides](http://guides.rubyonrails.org/) for more info on the following:

* Install Rails (>= 3.2.13) and Postgres (>= 9.1.9) and the requisite gems (n.b. there is a Gemfile)
* Create a user *median*, put the password in config/database.yml, give it create priviledges and generate the database
* Run the unit tests with `bundle exec rspec` to smoke test the installation
* Launch the rails server with `rails -s` from the root of the application
* Make curl requests to it; read the tests to get a feel for what you can do with it

## Comments and Feedback

If you've stumbled on this project and have some insight or correction to share, please do! You can reach me via gmail as egarson.

## License

Copyright © 2013 Edward Garson.

Distributed under the MIT License as described by LICENSE file distributed with this source code.
