# AttributeImagifiable


Using paperclip to generate images from sensible attributes like e-mails and telephone numbers, in order to reduce crawler's success

## Installation

Add this line to your application's Gemfile:

    gem 'attribute_imagifiable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attribute_imagifiable

## Usage

1. Generate Paperclip attachments

```
rails g paperclip person email_image
rails g paperclip person telephone_image
rake db:migrate
```

include and use in your Models:

```ruby

class Person < ActiveRecord::Base
...

  has_attached_file :telephone_image,
                    styles: {small: "150x105>"},
                    url: '/system/:class/:attachment/:id/:style/:filename'
  has_attached_file :email_image,
                    styles: {small: "150x105>"},
                    url: '/system/:class/:attachment/:id/:style/:filename'
  include AttributeImagifiable
  attribute_imagifiable :telephone, as: :telephone_image
  attribute_imagifiable :email, as: :mail_image

```
This will automatically generate an image for the "telephone" and "email" attribute before each update, if that attribute changed.

