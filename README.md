# ObjectFlatten

ObjectFlatten converts the hash to an array of key-value pairs.

[![Gem Version](https://badge.fury.io/rb/object_flatten.svg)](http://badge.fury.io/rb/object_flatten)
[![Build Status](https://travis-ci.org/winebarrel/object_flatten.svg?branch=master)](https://travis-ci.org/winebarrel/object_flatten)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'object_flatten'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install object_flatten

## Usage

```ruby
ObjectFlatten.flatten({"foo"=>"bar", "bar"=>"zoo"})
#=> [
#     {"foo"=>"bar"},
#     {"bar"=>"zoo"}
#   ]

ObjectFlatten.flatten({"foo"=>["bar", "zoo"]})
#=> [
#     {"foo"=>"bar"},
#     {"foo"=>"zoo"}
#   ]

ObjectFlatten.flatten({"foo"=>{"bar1"=>"zoo", "bar2"=>"baz"}})
#=> [
#     {"foo.bar1"=>"zoo"},
#     {"foo.bar2"=>"baz"}
#   ]

ObjectFlatten.flatten({"foo"=>{"bar1"=>"zoo", "bar2"=>"baz"}}, separator: '/')
#=> [
#     {"foo/bar1"=>"zoo"},
#     {"foo/bar2"=>"baz"}
#   ]

ObjectFlatten.flatten({"foo bar"=>{"zoo"=>"baz"}}, tr: [' ', '_'])
#=> [
#     {"foo_bar.zoo"=>"baz"}
#   ]

ObjectFlatten.flatten({
  "foo1"=>{"bar1"=>"zoo", "bar2"=>"baz"},
  "foo2"=>{"bar"=>["zoo", "baz"], "zoo"=>"baz"}
})
#=> [
#     {"foo1.bar1"=>"zoo"},
#     {"foo1.bar2"=>"baz"},
#     {"foo2.bar"=>"zoo"},
#     {"foo2.bar"=>"baz"},
#     {"foo2.zoo"=>"baz"}
#   ]
```
