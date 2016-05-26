# FourSquare Venues (iOS Swift) #

Example iOS Swift app using FourSquare API to search for venues nearby.

This application was developed as a demo for my tech talk during the first [Dublin Swift Meetup](http://www.meetup.com/Dublin-Swift-Meetup/events/230987906/). Check out the [slides](https://docs.google.com/presentation/d/16jVaQ3rgRfnrOm_vXvCyouQ_al8J-d4kzwz9sSjCaRk/edit?usp=sharing)!

Code for communicating with backend services (i.e.  [VenueGetVenuesByVenueId.swift](Sources/ApidocClients/FourSquare/Resource/VenueGetVenuesByVenueId.swift)) has been generated using [ApidocSwiftGenerator](https://github.com/kyle-dorman/ApidocSwiftGenerator), based on [Apidoc FourSquare service](http://www.apidoc.me/natalia/foursquare/latest) description.

![Demo](Resources/FSVenues-Demo.gif "Demo")

# Dependencies

* [CleanroomConcurrency](http://github.com/emaloney/CleanroomConcurrency)
* [CleanroomDataTransactions](http://github.com/emaloney/CleanroomDataTransactions)
* [CleanroomDateTime](http://github.com/emaloney/CleanroomDateTime)
* [PromiseKit](https://github.com/mxcl/PromiseKit)

