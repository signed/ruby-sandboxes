# How to test code in the `lib` folder?

https://stackoverflow.com/a/27311957
RSpec puts `lib` on the `$LOAD_PATH` so that you can require files relative to it

# How to setup vcr for testing?

https://fabioperrella.github.io/10_tips_to_help_using_the_VCR_gem_in_your_ruby_test_suite.html
https://dev.to/gathuku/testing-external-apis-with-vcr-in-rails-488m

https://dev.to/jorgefernando1/configure-vcr-with-rspec-48gh
- has good insights on how to do custom integration work into rspec

# How to write a fake implementation of a 3rd party service with Sinatra

https://thoughtbot.com/blog/how-to-stub-external-services-in-tests
https://github.com/zhengjia/sinatra-explained/blob/master/app/tutorial_2/tutorial_2.md

https://morningcoffee.io/sinatra-app-with-rspec.html
https://thoughtbot.com/blog/faking-apis-in-development-and-staging
https://avdi.codes/zero-to-smoke-test-with-sinatra/

https://github.com/Betterment/webvalve


# How to setup webvalve?
```ruby
group :development, :test do
  gem 'webvalve', '1.2'
end
```
`rails g webvalve:install`
Does not work outside rails out of the box.
Configuration is not found and the fake service can not be initialized using constantize from active record 
