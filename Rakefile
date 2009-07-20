require 'rubygems'

# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

begin
  require 'bones'
  Bones.setup
rescue LoadError
  begin
    load 'tasks/setup.rb'
  rescue LoadError
    raise RuntimeError, '### please install the "bones" gem ###'
  end
end

ensure_in_path 'lib'
require 'germinate'
require 'germinate/publisher'
require 'germinate-gist'

task :default => 'spec:run'

PROJ.name = 'germinate-gist'
PROJ.authors = 'Avdi Grimm'
PROJ.email = 'avdi@avdi.org'
PROJ.url = 'http://germinate-gist.rubyforge.com'
PROJ.version = GerminateGist::VERSION
PROJ.rubyforge.name = 'germinate-gist'

depend_on 'nokogiri',    '~> 1.2.3'
depend_on 'schacon-git', '~> 1.1.1'
depend_on 'rest_client', '~> 1.0.3'

PROJ.spec.opts << '--color'

# EOF
