module GerminateGist
  class UserError < RuntimeError
  end

  class GithubConfigError < UserError
    MESSAGE = <<END
No global Github config found.  See
http://github.com/blog/180-local-github-config for how to set up your login and
token.
END

    def initialize(message=MESSAGE)
      super
    end
  end
end
