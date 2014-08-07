Billbo
==============
[![Build Status](https://secure.travis-ci.org/piesync/billbo.png?branch=master)](http://travis-ci.org/piesync/billbo)
[![Code Climate](https://codeclimate.com/github/piesync/billbo.png)](https://codeclimate.com/github/piesync/billbo)
[![Test Coverage](https://codeclimate.com/github/piesync/billbo/coverage.png)](https://codeclimate.com/github/piesync/billbo)

About
-----

Billbo is an easy to use billing service including VAT support written in Ruby that is designed and built around the [Stripe] API. It decouples billing functionality from your application's core functionality and centralizes billing and invoicing logic into a stable workflow.

Billbo uses the Stripe invoicing system and adds VAT information/charges following legal regulations. As soon as a Stripe invoice charge succeeds, an internal invoice is created, generated in pdf and emailed to the customer.

It's currently designed to support billing from EU based countries.

[Stripe]: https://stripe.com/

Features
-----

* Automatic VAT addition according to legal regulations
* VAT number validation and owner details (company name, address)
* Automatic and consistent invoice numbering (configurable)
* Revenue analytics with [Segment.io](https://segment.io/) (optional)
* Error Tracking with [Getsentry](https://getsentry.com/) (optional)
* Automatic pdf invoice generation and emailing (work in progress)
* Battle-tested at [PieSync](http://www.piesync.com)

Deployment
------------

The easiest way to get Billbo online to use it for production is Heroku. The `deploy-heroku` script in the root directory helps you with that. It provisions a Heroku instance with a Postgres database and all the right settings.

The fastest path we can offer you:

```
git clone git@github.com:piesync/billbo.git && cd billbo
./deploy-heroku [HEROKU_APP_NAME] -s [SECRET_STRIPE_KEY]
```

The deploy script takes lots of additional options to customize your Billbo instance. Just run `./deploy-heroku` to see usage details.


Basic Usage
-----------
Billbo works with all different types of Stripe invoicing workflows, the only specifics you need are customer related.

### Creating Stripe Customers
Create Stripe customers with the following required metadata.

Example using Ruby:
```ruby
Stripe::Customer.create(
  card: "tok_14JuLq2nHroS7mLXZ5uxDRqs" # obtained with Stripe.js
  metadata: {
    country_code: 'US', # required - ISO 3166-1 alpha-2 standard
    vat_registered: true, # required
    ... # optional extra metadata
  }
)
```
This data and any extra metadata of your customers will be copied into the metadata of your Stripe invoices.
This way you can make your invoices immutable containing all their needed info taken at a certain point in time.


### Creating Subscriptions
To use Billbo in the correct way, instead of creating subscriptions using the Stripe API, create your subscriptions using Billbo.

Example using the Billbo Ruby Gem:
```ruby
Billbo.create_subscription(
  plan: 'basic',
  customer: 'cus_4XWKfwBrWLHvf8',
  ... # other Stripe compatible options
)
# => A Stripe::Subscription object
```

You can pass all options supported in the Stripe [create subscription](https://stripe.com/docs/api#create_subscription) call. The returned `Stripe::Subscription` or possible raised error are 100% compatible with the [Stripe Ruby Gem](https://github.com/stripe/stripe-ruby).

Help and Discussion
-------------------

If you need help you can contact us by sending a message to:
[oss@piesync.com][mail].

[mail]:   mailto:oss@piesync.com

If you believe you've found a bug, please report it at:
https://github.com/piesync/billbo/issues


Contributing to Billbo
----------------------------

* Please fork Billbo on github
* Make your changes and send us a pull request with a brief description of your addition
* We will review all pull requests and merge them upon approval

Copyright
---------

Copyright (c) 2014 PieSync.
