# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{germinate-gist}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Avdi Grimm"]
  s.date = %q{2009-07-20}
  s.default_executable = %q{germinate-gist}
  s.description = %q{A Germinate plugin for publishing source code to the Gist service (http://gist.github.com)  See Germinate: http://github.com/devver/germinate/}
  s.email = %q{avdi@avdi.org}
  s.executables = ["germinate-gist"]
  s.extra_rdoc_files = ["History.txt", "README.txt", "bin/germinate-gist"]
  s.files = ["History.txt", "README.txt", "Rakefile", "bin/germinate-gist", "lib/germinate-gist.rb", "lib/germinate-gist/errors.rb", "lib/germinate-gist/gist_publisher.rb", "lib/germinate_plugin_v0_init.rb", "spec/germinate-gist/gist_publiser_spec.rb", "spec/germinate-gist/gist_publisher.rb", "spec/germinate-gist_spec.rb", "spec/spec_helper.rb", "tasks/ann.rake", "tasks/bones.rake", "tasks/gem.rake", "tasks/git.rake", "tasks/notes.rake", "tasks/post_load.rake", "tasks/rdoc.rake", "tasks/rubyforge.rake", "tasks/setup.rb", "tasks/spec.rake", "tasks/svn.rake", "tasks/test.rake", "tasks/zentest.rake", "test/test_germinate-gist.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/devver/germinate-gist/}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{germinate-gist}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A Germinate plugin for publishing source code to the Gist service (http://gist}
  s.test_files = ["test/test_germinate-gist.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.2.3"])
      s.add_runtime_dependency(%q<schacon-git>, ["~> 1.1.1"])
      s.add_runtime_dependency(%q<rest_client>, ["~> 1.0.3"])
      s.add_development_dependency(%q<bones>, [">= 2.5.1"])
    else
      s.add_dependency(%q<nokogiri>, ["~> 1.2.3"])
      s.add_dependency(%q<schacon-git>, ["~> 1.1.1"])
      s.add_dependency(%q<rest_client>, ["~> 1.0.3"])
      s.add_dependency(%q<bones>, [">= 2.5.1"])
    end
  else
    s.add_dependency(%q<nokogiri>, ["~> 1.2.3"])
    s.add_dependency(%q<schacon-git>, ["~> 1.1.1"])
    s.add_dependency(%q<rest_client>, ["~> 1.0.3"])
    s.add_dependency(%q<bones>, [">= 2.5.1"])
  end
end
