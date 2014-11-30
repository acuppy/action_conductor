# Handler
[![Build Status](https://travis-ci.org/acuppy/handler.svg?branch=master)](https://travis-ci.org/acuppy/handler)
DRY-up Rails Controllers with handlers

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'handler'
```

And then execute:

    $ bundle

## Usage

Define a Handler

```ruby
class PagesHandler < Handler::Base
    def handle
        # controller
        # params
        # return true/false to defined self#handled?
    end
end
```

Bind it to a Rails Controller

```ruby
class PagesController < ApplicationController
    handler :pages, only: [:show]
    # ...
end
```

Access handled values via the `handle` method
```ruby
class PagesController < ApplicationController
    # ...
    def show
        @page = handle(:page)
    end
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/handler/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
