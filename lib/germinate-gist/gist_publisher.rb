require 'git'
require 'rest_client'
require 'pathname'
require 'nokogiri'

class GerminateGist::GistPublisher < Germinate::Publisher
  identifier "gist"

  GISTS_URL         = 'http://gist.github.com/gists'
  NEW_GIST_URL      = 'http://gist.github.com/api/v1/xml/new'
  EXISTING_GIST_URL = 'http://gist.github.com/api/v1/xml/'
  PUBLIC_GIST_URL   = 'http://gist.github.com/'

  def initialize(name, librarian, options={})
    @resource_class = options.delete(:resource_class) { RestClient::Resource }
    super
    @git = Git.init
    self.selector = "$SOURCE"
  end

  def publish!(output, extra_options={})
    if librarian.variables.key?('GIST_ID')
      put_gist!(librarian.variables['GIST_ID'])
    else
      post_gist!
    end

  rescue RestClient::ExceptionWithResponse => error
    log.error "Error posting to gist: #{error.message}"
    log.debug "Response from Gist: #{error.response.message}\n#{error.response.body}"
    raise UserError, error.message
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
    source_path.extname.to_s
  end

  def basename
    source_path.basename.to_s
  end

  def gist_data
    {
      'file_ext' => {
        basename => extname
      },
      'file_name' => {
        basename => basename
      },
      'file_contents' => {
        basename => input.join
      },
      'login'                       => github_login,
      'token'                       => github_token
    }
  end

  def post_gist!
    gists = @resource_class.new(NEW_GIST_URL)
    response = gists.post(gist_data)
    log.debug "Gist Response:\n#{response}"
    gist_id = extract_gist_id(response)
    log.info "Gist published at #{gist_public_url(gist_id)}"
    librarian.variables['GIST_ID'] = gist_id
  end

  # See http://support.github.com/discussions/gist/65-update-gists-in-the-api
  def put_gist!(gist_id)
    gist = @resource_class.new('http://gist.github.com/gists/' + gist_id)
    response = gist.put(gist_data)
    log.debug "Gist PUT response:\n#{response}"
    log.info "Gist #{gist_public_url(gist_id)} updated"
  end

  def extract_gist_id(response)
    Nokogiri::XML.parse(response).xpath('//repo').first.content
  end

  def gist_public_url(gist_id)
    PUBLIC_GIST_URL + gist_id
  end
end
