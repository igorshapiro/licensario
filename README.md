# Licensario

This gem provides an easy way to integrate Licensario's API with you awesome Ruby application.

## Installation

If you are working with Rails or any Bundler-enabled applications, you just have to:

Add this line to your application's Gemfile:

```ruby
    gem 'licensario'
```

And then execute:

```bash
    $ bundle
```

Or install it yourself as:

```bash
    $ gem install licensario
```

## Usage

This gem provides you with a couple of resource classes that you can use in your applications, coupled with a 
base API class which you need to configure before start working. These are the steps you need to follow:

1. **Configure**: first you need to setup your connection to Licensario's API server. You can do so by:

```ruby
    Licensario::Base.establish_connection(key: "MY_API_KEY" , secret: "MY_API_SECRET" )  
```

2. **Use**: now you can start playing with Licensario's interface classes. This gem provides you with four 
public accessible ones: *Licensario::User*, *Licensario::License*, *Licensario::LicensedResource* and *Licensario::LicensedFeature*. 
You can now do cool things like:

```ruby
    # Initialize an User
    user = Licensario::Base.new(external_user_id: 1, email: 'some@user.net')

    # Retrieve this user's Licenses
    feature_ids = [1..100]
    payment_plan_ids = [1..100]
    licenses = user.get_licenses(feature_ids, payment_plan_ids)

    # Get the current amount available of a given Feature
    feature_id = '19273812'
    payment_plan_id = '123987128'
    feature_amount = user.get_available_feature_amount(feature_id, payment_plan_id)

    # Increment the previous feature's usage (i.e. diminish the available amount)
    user.increment_feature_usage(1, feature_id, payment_plan_id)

    # Create a new License for this User
    new_license = user.create_license(payment_plan_id)
```

3. **Rock'n'Roll'**: Now that you have the hang of it, be sure to take a look at the [RDocs](licensario/docs/index.html) for more detailed information 
on the finer aspects of the gem. Don't worry, we made sure to make it super easy to get you up and running in no time.

*Good luck!*

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
