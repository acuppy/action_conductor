# Handler
[![Build Status](https://travis-ci.org/acuppy/handler.svg?branch=master)](https://travis-ci.org/acuppy/handler)[![Code Climate](https://codeclimate.com/github/acuppy/handler/badges/gpa.svg)](https://codeclimate.com/github/acuppy/handler)

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
  
  # pass it a value directly
  export :page, "Hello World"
  
  # delegate to a block for compilation 
  export :meta do
    "some computed value"
  end
  
  # optionally pass arguments from the computed action to the computed value
  export :foo do |args|
    "some computed value with arguments"
  end
  
  # blocks are executed in the context of the handler instance, so...
  export :bar do
    bar_handler
  end
  
  # ... delegates to ...
  def bar_handler
  end
  
  # exports are exported in the same order they are established, but you can override that order...
  order :foo, :page, :meta, :bar
end
```

Bind it to a Rails Controller

```ruby
class PagesController < ApplicationController
  handler :pages, only: [:show]
  # ...
end
```

Export computed values via `handler.exports`
```ruby
class PagesController < ApplicationController
  # ...
  def show
    @page = handler.exports
  end
end
```
or export multiple computed values

```ruby
class PagesController < ApplicationController
  # ...
  def show
    @page, @meta = handler.exports # => exports in the established order 
  end
end
```
explicitly declare which exports to export, and in which order
```ruby
class PagesController < ApplicationController
  # ...
  def show
    @meta, @page = handler.exports(:meta, :page)
  end
end
```
Pass arguments to the export block
```ruby
class PagesController < ApplicationController
  # ...
  def show
    @address = handler.exports(:address, "111 Main St.")
  end
end

class PagesHandler < Handler::Base
  export :address do |street|
    "#{street} Medford, OR 97501"
  end
end
```

Like Controller filters, handlers are inherited and override (or skip) established handlers

```ruby
class PagesController < ApplicationController
  handler :pages, only: [:show]
  # ...
end

class AdminPagesController < PagesController
  unset_handler :pages
  # ...
end
```

Extend an existing handler, while keeping it's established constraints.  Extending handler exports (e.g. AdminPagesHandler) will be added down the export chain
```ruby
class AdminPagesController < PagesController
  handler :admin_pages, extend: :pages
  
  def show
    @meta, @page, @admins = handler.exports(:meta, :page, :admins) # => all values available
  end
  
  # ...
end
```

Or entirely replace an inherited handler, while keeping it's established constraints
```ruby
class AdminPagesController < PagesController
  handler :admin_pages, replace: :pages
  
  def show
    @meta, @page = handler.exports(:meta, :page) # => nil
    @admins = handler.exports(:admin) # => some value
  end
  # ...
end
```

If you need to access a specific handler, with a conflicting named exports, handler methods are automatically scoped via a prefix.  You can continue to access the entire export collection via the root `handler`
```ruby
class PagesController < ApplicationController
  handler :pages
  # ...
end

class AdminPagesController < PagesController
  handler :admin_pages
  
  def show
    @page = pages_handler.exports(:page)
    @admin_page = admin_pages_handler.exports(:page)
    @admin_page = handler.exports(:page) # => exports the latest established export (AdminPages)
  end
  # ...
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/handler/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
