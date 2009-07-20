require 'git'
require 'rest_client'
require 'pathname'

class GerminateGist::GistPublisher < Germinate::Publisher
  identifier "gist"

  GISTS_URL = 'http://gist.github.com/gists'

  def initialize(name, librarian, options={})
    super
    @git = Git.init
    self.selector = "$SOURCE"
  end

  def publish!(output, extra_options={})
    gists = RestClient::Resource.new(GISTS_URL)
    response = gists.post(gist_data)
    log.debug "Gist Response:\n#{response}"
  end

  def github_login
    @git.config('github.user') or raise GerminateGist::GithubConfigError
  end

  def github_token
    @git.config('github.token') or raise GerminateGist::GithubConfigError
  end

  private

  def source_path
    Pathname(input.source_path)
  end

  def extname
    source_path.extname
  end

  def basename
    source_path.basename(extname).to_s
  end

  def gist_data
    {
      'file_ext[gistfile1]'      => extname,
      'file_name[gistfile1]'     => basename,
      'file_contents[gistfile1]' => input.join,
      'login'                    => github_login,
      'token'                    => github_token
    }
  end
end
