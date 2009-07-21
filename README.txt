= germinate-gist

by Avdi Grimm

http://github.com/devver/germinate-gist/

== DESCRIPTION

A Germinate plugin for publishing source code to the Gist service (http://gist.github.com)

See Germinate: http://github.com/devver/germinate/

== FEATURES

* Uses your global github.user/github.token config variables
* Updates the source file with the Gist ID
* Publishing again will update the same Gist, won't start a new one

== SYNOPSIS:

  $ cat my_article.rb
  # :PUBLISHER: source, gist
  # This is my awesome article
  puts "Hello, world"

  $ germ publish source my_article.rb
  INFO -- germinate: Gist published at http://gist.github.com/12345

  $ echo " # more text..." >> my_article.rb
  $ germ publish source my_article.rb
  INFO -- germinate: Gist http://gist.github.com/12345 updated


== REQUIREMENTS:

* Nokogiri
* schacon-git
* RestClient

== INSTALL:

* sudo gem install devver-germinate-gist --source http://gems.github.com

== LICENSE:

(The MIT License)

Copyright (c) 2009

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
