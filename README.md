# Market Money

### About

You are working for a company developing an interface to help people find sustainable and local alternatives for their lifestyle in their area. One of their features to encourage supporting local growers/crafters/etc., is a Farmers Market lookup. Your company uses a Micro Service Architecture, and needs you to build out the service that is responsible for providing functionality for Farmers Market & Vendors.

Your job is to expose the data that powers this part of the site through an API that the front end would consume. You won’t be building an actual front end for this project.

### Setup

```
bundle install
rails db:{drop,create,migrate,seed}
rails db:schema:dump
```

### Versions

- Ruby 3.2.2
- Rails 7.1.2

### Goals

Feature Delivery
Project completes all requirements
- [x] User Story 1 - Get All Markets
- [x] User Story 2 - Get One Market
- [x] User Story 3 - Get All Vendors for a Market
- [x] User Story 4 - Get One Vendor
- [x] User Story 5 - Create a Vendor
- [x] User Story 6 - Update a Vendor
- [x] User Story 7 - Delete a Vendor
- [x] User Story 8 - Create a MarketVendor
- [x] User Story 9 - Delete a MarketVendor
- [x] User Story 10 - Search Markets by state, city, and/or name
- [x] User Story 11 - Get Cash Dispensers Near a Market

Test Driven Development (TDD)
- [x] Project achieves greater than 90% test coverage overall

Technical Quality
- [ ] Project demonstrates solid code quality
- [ ] Project demonstrates MVC principles, 
- [ ] Project uses a serializer for formatting JSON responses.

10 Minute Video Presentation
- [ ] Demonstration of functionality via Postman suites
- [ ] Technical quality and organization of the code, identifying code that should be refactored and how it would be refactored
- [ ] Running your application’s test suite and a discussion of test coverage (happy/sad paths and any edge cases)
- [ ] Identifying the area(s) of code of which you are most proud, and an area where you would like specific feedback
- [ ] All team members speak

### Tests

* 59 Tests Total (100% coverage on 759/759 LOC)
* 31 Request Tests (100% coverage on 629/629 LOC)
* 26 Model Tests (100% coverage on 127/127 LOC)

- [x] User Story 1 - Happy Path (1)
- [x] User Story 2 - Happy Path (1)
- [x] User Story 2 - Sad Path (1)
- [x] User Story 3 - Happy Path (1)
- [x] User Story 3 - Sad Path (1)
- [x] User Story 4 - Happy Path (1)
- [x] User Story 4 - Sad Path (1)
- [x] User Story 5 - Happy Path (1)
- [x] User Story 5 - Sad Path (1)
- [x] User Story 6 - Happy Path (1)
- [x] User Story 6 - Sad Path (2)
- [x] User Story 7 - Happy Path (1)
- [x] User Story 7 - Sad Path (2)
- [x] User Story 8 - Happy Path (1)
- [x] User Story 8 - Sad Path (5)
- [x] User Story 9 - Happy Path (1)
- [x] User Story 9 - Sad Path (1)
- [x] User Story 10 - Happy Path (3)
- [x] User Story 10 - Sad Path (2)
- [x] User Story 11 - Happy Path (3)
- [x] User Story 11 - Sad Path (1)

### Contributors

* Grant Davis | [Grant's GitHub](https://github.com/grantdavis303)
* Luis Aparicio | [Luis' GitHub](https://github.com/LuisAparicio14)