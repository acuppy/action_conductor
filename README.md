# Action Conductor
[![Build Status](https://travis-ci.org/acuppy/action_conductor.svg?branch=master)](https://travis-ci.org/acuppy/action_conductor)[![Code Climate](https://codeclimate.com/github/acuppy/conductor/badges/gpa.svg)](https://codeclimate.com/github/acuppy/action_conductor)

DRY-up Rails Controllers with conductors

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'action_conductor'
```

And then execute:

```
$ bundle
```

## Usage

Define a Conductor in `app/conductors`

```ruby
class PagesConductor < ActionConductor::Base

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
end
```

Bind it to a Rails Controller

```ruby
class PagesController < ApplicationController
  conductor :pages
  # ...
end
```

Export computed values via `exports`
```ruby
class PagesController < ApplicationController
  # ...
  def show
    @page = exports
  end
end
```
or export multiple computed values

```ruby
class PagesController < ApplicationController
  # ...
  def show
    @page, @meta = exports # => exports in the established order
  end
end
```
explicitly declare which exports to export, and in which order
```ruby
class PagesController < ApplicationController
  # ...
  def show
    @meta, @page = exports(:meta, :page)
  end
end
```
Pass arguments to the export block
```ruby
class PagesController < ApplicationController
  # ...
  def show
    @address = exports(:address, "111 Main St.")
  end
end

class PagesConductor < ActionConductor::Base
  export :address do |street|
    "#{street} Medford, OR 97501"
  end
end
```

In case there is a competing `exports` method on the controller, you can access it through
the `conductor` instance

```ruby
class PagesController < ApplicationController
  # ...
  def show
    @foo = conductor.exports(:foo)
  end
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/conductor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
