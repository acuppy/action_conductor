# Conductor
[![Build Status](https://travis-ci.org/acuppy/conductor.svg?branch=master)](https://travis-ci.org/acuppy/conductor)[![Code Climate](https://codeclimate.com/github/acuppy/conductor/badges/gpa.svg)](https://codeclimate.com/github/acuppy/conductor)

DRY-up Rails Controllers with conductors

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'conductor-rails'
```

And then execute:

    $ bundle

## Usage

Define a Conductor in `app/conductors`

```ruby
class PagesConductor < Conductor::Base

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

  # blocks are executed in the context of the conductor instance, so...
  export :bar do
    bar_conductor
  end

  # ... delegates to ...
  def bar_conductor
  end

  # exports are exported in the same order they are established, but you can override that order...
  order :foo, :page, :meta, :bar
end
```

Bind it to a Rails Controller

```ruby
class PagesController < ApplicationController
  conductor :pages, only: [:show]
  # ...
end
```

Export computed values via `conductor.exports`
```ruby
class PagesController < ApplicationController
  # ...
  def show
    @page = conductor.exports
  end
end
```
or export multiple computed values

```ruby
class PagesController < ApplicationController
  # ...
  def show
    @page, @meta = conductor.exports # => exports in the established order
  end
end
```
explicitly declare which exports to export, and in which order
```ruby
class PagesController < ApplicationController
  # ...
  def show
    @meta, @page = conductor.exports(:meta, :page)
  end
end
```
Pass arguments to the export block
```ruby
class PagesController < ApplicationController
  # ...
  def show
    @address = conductor.exports(:address, "111 Main St.")
  end
end

class PagesConductor < Conductor::Base
  export :address do |street|
    "#{street} Medford, OR 97501"
  end
end
```

Like Controller filters, conductors are inherited and override (or skip) established conductors

```ruby
class PagesController < ApplicationController
  conductor :pages, only: [:show]
  # ...
end

class AdminPagesController < PagesController
  unset_conductor :pages
  # ...
end
```

Extend an existing conductor, while keeping it's established constraints.  Extending conductor exports (e.g. AdminPagesConductor) will be added down the export chain
```ruby
class AdminPagesController < PagesController
  conductor :admin_pages, extend: :pages

  def show
    @meta, @page, @admins = conductor.exports(:meta, :page, :admins) # => all values available
  end

  # ...
end
```

Or entirely replace an inherited conductor, while keeping it's established constraints
```ruby
class AdminPagesController < PagesController
  conductor :admin_pages, replace: :pages

  def show
    @meta, @page = conductor.exports(:meta, :page) # => nil
    @admins = conductor.exports(:admin) # => some value
  end
  # ...
end
```

If you need to access a specific conductor, with a conflicting named exports, conductor methods are automatically scoped via a prefix.  You can continue to access the entire export collection via the root `conductor`
```ruby
class PagesController < ApplicationController
  conductor :pages
  # ...
end

class AdminPagesController < PagesController
  conductor :admin_pages

  def show
    @page = pages_conductor.exports(:page)
    @admin_page = admin_pages_conductor.exports(:page)
    @admin_page = conductor.exports(:page) # => exports the latest established export (AdminPages)
  end
  # ...
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/conductor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
