require File.join(File.dirname(__FILE__), %w[.. spec_helper])

module GerminateGist
  describe GistPublisher do
    before :each do
      @git       = stub("Git")
      @hunk      = Germinate::Hunk.new(["line 1\n", "line 2\n"])
      @contents  = "line 1\nline 2\n"
      @librarian = stub("Librarian", :[] => @hunk, :make_pipeline => lambda{|x|x})
      @output    = stub("Output")
      @gists     = stub("Gists Resource")
      @hunk.stub!(:source_path).and_return("/some/path/my_article.c")
      RestClient::Resource.stub!(:new).
        with('http://gist.github.com/gists').and_return(@gists)
      Git.stub!(:init).and_return(@git)
    end

    it "should be a kind of Publisher" do
      GistPublisher.should be < Germinate::Publisher
    end

    it "should identify itself as 'gist'" do
      GistPublisher.identifier.should == "gist"
    end

    context "given a name and a librarian" do
      before :each do
        @it = GistPublisher.new("source", @librarian, {})
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
        
        @it = GistPublisher.new("source", @librarian, {})
      end
      
      it "should know the user's github login" do
        @it.github_login.should == "johnq"
      end

      it "should know the user's github token" do
        @it.github_token.should == "abcde"
      end

      it "should be able to post a new gist" do
        @gists.should_receive(:post).
          with(
          {
            'file_ext[gistfile1]'      => '.c',
            'file_name[gistfile1]'     => 'my_article',
            'file_contents[gistfile1]' => @contents,
            'login'                    => 'johnq',
            'token'                    => 'abcde'
          })
        @it.publish!(@output)
      end
    end

    context "given no global github user config" do

      before :each do
        @git.stub!(:config).with('github.user').and_return(nil)
        @git.stub!(:config).with('github.token').and_return(nil)
        @it = GistPublisher.new("source", @librarian, {})
      end
      
      it "should fail fast if login is missing" do
        lambda do
          @it.github_login
        end.should raise_error(GithubConfigError)
      end

      it "should fail fast if token is missing" do
        lambda do
          @it.github_token
        end.should raise_error(GithubConfigError)
      end

    end
  end
end
