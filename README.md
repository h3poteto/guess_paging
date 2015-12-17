# guess_paging

guess_paging is a pagination library, and this library work wonderfully when you treat many records in RDB.

## Features
### Light workload
General pagination libraries calculate records size to display accurate last page number. But sometimes, count query is too heavy workload for database, if you use heavy SQL Query. In the result, page speed slow.

guess_paging calculate and cache records size at the first time. From then on, guess_paging not count records size, and display last page number of suitable size. When user click that last page, once again calculate accurate last page number, and refhres cache.
When user visit first page and halfway pages, count query is not called.

So, guess_paging is light workload for database, because it call count query at the first time and last page only.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'guess_paging'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install guess_paging

## Usage

### Setup redis
This gem requires `redis`, so please prepare `redis-server` and setup redis in initializer.

```ruby
GuessPaging::RedisClient.setup do |config|
  config.redis_host = '127.0.0.1'
  config.redis_port = 6379
end
```

### Controllers
```ruby
class RecordsController < ApplicationController
  def search
    @guess = GuessPaging::Paginate.new(
      query: Record.where(category_id: params[:category_id].to_i),
      per_page: 10)
    @guess.guess(
      page_params: params[:page]
    )
  end
end
```

### Views
```erb
<%= paging(@guess) %>
```

### Helpers
- output pagination view
  
  ```erb
  <%= paging(@guess) %>
  ```
- current page number
  
  ```ruby
  @guess.current_page
  ```

- last page number of suitable size
  
  ```ruby
  @guess.max_page
  ```

- record number of suitable size.
  
  ```ruby
  @guess.count
  ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/guess_paging. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

