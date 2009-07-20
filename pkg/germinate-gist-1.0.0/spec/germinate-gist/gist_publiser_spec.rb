require File.join(File.dirname(__FILE__), %w[.. spec_helper])

module GerminateGist
  describe GistPublisher do
    before :each do
      @git       = stub("Git")
      @hunk      = Germinate::Hunk.new(["line 1\n", "line 2\n"])
      @contents  = "line 1\nline 2\n"
      @variables = {}
      @librarian = stub("Librarian", 
        :[]            => @hunk, 
        :make_pipeline => lambda{|x|x},
        :variables     => @variables)
      @output    = stub("Output")
      @hunk.stub!(:source_path).and_return("/some/path/my_article.c")
      @post_response = <<'END'
<?xml version="1.0" encoding="UTF-8"?>
<gists type="array">
  <gist>
    <public type="boolean">true</public>
    <description nil="true"></description>
    <repo>12345</repo>
    <created-at type="datetime">2008-08-06T13:30:32-07:00</created-at>
  </gist>
</gists>
END
      @gists     = stub("Gists Resource", :post => @post_response)
      @gist      = stub("Single Gist Resource", :put => @post_response)
      @gist_id   = "54321"
      @resource_class = stub("Resource Class")
      Git.stub!(:init).and_return(@git)
      @resource_class.stub!(:new).and_return(@gists)
    end

    it "should be a kind of Publisher" do
      GistPublisher.should be < Germinate::Publisher
    end

    it "should identify itself as 'gist'" do
      GistPublisher.identifier.should == "gist"
    end

    context "given a name and a librarian" do
      before :each do
        @it = GistPublisher.new("source", @librarian, {:resource_class => @resource_class})
      end

      it "should know its own name" do
        @it.name.should == "source"
      end

      it "should have a default selector of $SOURCE" do
        @it.selector.should == "$SOURCE"
      end
    end

    context "given a global git config" do

      before :each do
        @git = stub("Git")
        @git.stub!(:config).with('github.user').and_return("johnq")
        @git.stub!(:config).with('github.token').and_return("abcde")
        Git.stub!(:init).and_return(@git)
        
        @it = GistPublisher.new("source", @librarian, {:resource_class => @resource_class})
      end
      
      it "should know the user's github login" do
        @it.github_login.should == "johnq"
      end

      it "should know the user's github token" do
        @it.github_token.should == "abcde"
      end

      context "publishing" do
        it "should be able to post a new gist" do
          @gists.should_receive(:post).
            with(
            {
              'file_ext[my_article.c]'      => '.c',
              'file_name[my_article.c]'     => 'my_article',
              'file_contents[my_article.c]' => @contents,
              'login'                       => 'johnq',
              'token'                       => 'abcde'
            })
          @it.publish!(@output)
        end

        it "should save the published gist ID in a variable" do
          @variables.should_receive(:[]=).with('GIST_ID', '12345')
          @it.publish!(@output)
        end
      end
    end

    context "given a pre-existing gist" do
      before :each do
        @git = stub("Git")
        @git.stub!(:config).with('github.user').and_return("johnq")
        @git.stub!(:config).with('github.token').and_return("abcde")
        Git.stub!(:init).and_return(@git)
        @resource_class = stub("Resource Class")
        @it = GistPublisher.new("source", @librarian, {:resource_class => @resource_class})
        @variables['GIST_ID'] = '54321'
      end

      context "on publish" do
        it "should update the pre-exsting gist" do
          @resource_class.should_receive(:new).
            with("http://gist.github.com/api/v1/xml/#{@gist_id}").
            and_return(@gist)

          @gist.should_receive(:put).with(
            {
              'file_ext[my_article.c]'      => '.c',
              'file_name[my_article.c]'     => 'my_article',
              'file_contents[my_article.c]' => @contents,
              'login'                       => 'johnq',
              'token'                       => 'abcde'
            })
           @it.publish!(@output)
       end
      end
    end

    context "given no global github user config" do

      before :each do
        @git.stub!(:config).with('github.user').and_return(nil)
        @git.stub!(:config).with('github.token').and_return(nil)
        @it = GistPublisher.new("source", @librarian, {:resource_class => @resource_class})
      end
      
      it "should fail fast trying to access github login" do
        lambda do
          @it.github_login
        end.should raise_error(GithubConfigError)
      end

      it "should fail fast trying to access github token" do
        lambda do
          @it.github_token
        end.should raise_error(GithubConfigError)
      end

    end
  end
end
