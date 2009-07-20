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
PROJ.url = 'FIXME (project homepage)'
PROJ.version = GerminateGist::VERSION
PROJ.rubyforge.name = 'germinate-gist'

PROJ.spec.opts << '--color'

# EOF
