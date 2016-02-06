# Ryakuzu
#### Interface for schema.rb
[![Gem Version](https://badge.fury.io/rb/ryakuzu.svg)](https://badge.fury.io/rb/ryakuzu) [![Build Status](https://travis-ci.org/ID25/ryakuzu.svg?branch=master)](https://travis-ci.org/ID25/ryakuzu)

![Alt text](http://i.imgur.com/71EVVrQ.png "Ryakuzu")
___
##### Ryakuzu provides simple CRUD operations on your schema.rb and starts the migration for you. All migration files are automatically deleted after migration.

![alt text](http://i.imgur.com/suMAGyX.png "Screen")
## Install

```ruby
group :development do
  gem 'ryakuzu'
end
```

##### Now you can visit ``http://localhost:3000/ryakuzu``

## Features
#### Tables:
+ Create table (also created model)
+ Remove table (model not deleted)
+ Rename table

#### Columns:
+ Create column
+ Remove column
+ Rename Column
+ Change column type (`string, integer`, etc...)
+ Add default value for column (`:integer, :price, default: 99`)

#### Other
+ Save schema to CSV


## Contributing

+ Fork it
+ Create your feature branch (git checkout -b my-new-feature)
+ Commit your changes (git commit -am 'Added some feature')
+ Push to the branch (git push origin my-new-feature)
+ Create new Pull Request

## ToDo:
+ Write more tests
+ Add index, null, default to edit
+ Make select for choice associations.

## The MIT License (MIT)

Copyright (c) 2015-2016 Eugene Domosedov (ID25)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
