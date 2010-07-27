require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Generators" do
  
  describe Choco::AppGenerator do
    
    before(:all) do
      @project_path = 'spec/tmp/test_project'
      Choco::AppGenerator.start @project_path
    end
    
    after(:all) do
      FileUtils.rm_rf @project_path
    end
    
    it "should generate the project folder" do
      File.exist?(@project_path).should be_true
    end
    
    it "should generate the app folder" do
      File.exist?(@project_path + '/app').should be_true
      File.exist?(@project_path + '/app/controllers').should be_true
      File.exist?(@project_path + '/app/helpers').should be_true
      File.exist?(@project_path + '/app/models').should be_true
      File.exist?(@project_path + '/app/views').should be_true
      File.exist?(@project_path + '/app/controllers/application_controller.js').should be_true
      File.exist?(@project_path + '/app/views/main/index.template').should be_true
      File.exist?(@project_path + '/app/helpers/application_helper.js').should be_true
    end
    
    it "should generate the lib folder" do
      File.exist?(@project_path + '/lib').should be_true
      File.exist?(@project_path + '/lib/application.js').should be_true
    end
    
    it "should generate the images folder" do
      File.exist?(@project_path + '/images').should be_true
    end
    
    it "should generate the stylesheets folder" do
      File.exist?(@project_path + '/stylesheets').should be_true
      File.exist?(@project_path + '/stylesheets/application.css').should be_true      
    end
    
    it "should generate the fixtures folder" do
      File.exist?(@project_path + '/fixtures').should be_true
    end    
    
    it "should generate the spec folder" do
      File.exist?(@project_path + '/spec').should be_true
    end
    
    it "should generate the script folder" do
      File.exist?(@project_path + '/script').should be_true
      File.exist?(@project_path + '/script/choco').should be_true      
    end
    
    it "should generate the main files" do
      File.exist?(@project_path + '/Jimfile').should be_true
      File.exist?(@project_path + '/Rakefile').should be_true
      File.exist?(@project_path + '/README.rdoc').should be_true
      File.exist?(@project_path + '/index.html').should be_true              
    end
    
    describe "templates" do
      
      describe "ApplicationController" do
      
        it "should set the views path to the project views folder" do
          file = get_file_as_string(@project_path + '/app/controllers/application_controller.js')
          file.include?("this.project_path = '/spec/tmp/test_project';").should be_true
        end
      end
      
      describe "index.html" do
        
        before(:all) do
          @file = get_file_as_string(@project_path + '/index.html')
        end
        
        it "should include the bundled.js file" do
          @file.include?('<script src="lib/bundled.js" type="text/javascript"></script>').should be_true
        end
        
        it "should include the root div" do
          @file.include?('<div id="choco"></div>').should be_true
        end
        
      end
      
    end
  end
  
  describe "code generators" do
    
    before(:all) do
      @project_path = 'spec/tmp/test_project'
      Choco::AppGenerator.start @project_path
      FileUtils.cd(@project_path)
    end
    
    after(:all) do
      FileUtils.cd('..')
      FileUtils.rm_rf('test_project')
      FileUtils.cd('../..')
    end
    
    describe Choco::ControllerGenerator do
      
      it "should generate a controller file and a views folder" do
        Choco::ControllerGenerator.start 'posts'
        File.exist?('app/controllers/posts_controller.js').should be_true
        File.exist?('app/views/posts').should be_true        
      end
      
      it "should not pluralize the controller name" do
        Choco::ControllerGenerator.start 'singular'
        File.exist?('app/controllers/singular_controller.js').should be_true
      end
      
      it "should underscore the name" do
        Choco::ControllerGenerator.start 'UnderScore'
        File.exist?('app/controllers/under_score_controller.js').should be_true
      end      
      
      describe "templates" do
        
        before(:all) do
          Choco::ControllerGenerator.start 'UnderScore'
          @file = get_file_as_string('app/controllers/under_score_controller.js')
        end
        
        describe "the generated controller" do
          it "should be named correctly" do
            @file.include?('UnderScoreController').should be_true
          end
          
          it "should define an index route" do
            @file.include?("get('#/under_score'").should be_true
          end          
        end
      end
    end
    
    describe Choco::ModelGenerator do
      it "should generate a model file" do
        Choco::ModelGenerator.start 'post'
        File.exist?('app/models/post.js').should be_true
      end
      
      it "should generate a model file with a singular name" do
        Choco::ModelGenerator.start 'posts'
        File.exist?('app/models/post.js').should be_true
      end
      
      describe "templates" do
        
        describe "the generated model" do
          
          before(:all) do
            Choco::ModelGenerator.start 'post'
            @file = get_file_as_string('app/models/post.js')
          end
          
          it "should be named correctly" do
            @file.include?('var Post = Model("post"').should be_true
          end
          
          it "model persistence URL should be correct" do
            @file.include?('Model.RestPersistence("/posts")').should be_true
          end          
        end
        
      end
    end
    
    describe Choco::LayoutGenerator do
      it "should generate a layout file" do
        Choco::LayoutGenerator.start 'main'
        File.exist?('app/views/layouts/main.js').should be_true
      end
      
      describe "templates" do
        
        it "the layout should be named correctly" do
          Choco::LayoutGenerator.start 'main'
          file = get_file_as_string('app/views/layouts/main.js')
          file.include?('var MainLayout').should be_true
        end
        
      end
      
    end
    
    describe Choco::FixtureGenerator do
      it "should generate a fixture file" do
        Choco::FixtureGenerator.start 'posts'
        File.exist?('fixtures/posts.js').should be_true
      end
      
      it "should generate a fixture folder" do
        Choco::FixtureGenerator.start 'posts'
        File.exist?('fixtures/posts').should be_true
        File.exist?('fixtures/posts/posts.json').should be_true
      end
      
      describe "templates" do
        
        it "the URL should have a correct format" do
          Choco::FixtureGenerator.start 'post'
          file = get_file_as_string('fixtures/posts.js')
          file.include?("url: '/posts',").should be_true
        end
        
      end
      
    end
    
    describe Choco::PluginGenerator do
      it "should generate a plugin file" do
        Choco::PluginGenerator.start 'live'
        File.exist?('lib/plugin_live.js').should be_true
      end
      
      describe "templates" do
        
        describe "the generated plugin" do
        
          before(:all) do
            Choco::PluginGenerator.start 'live'
            @file = get_file_as_string('lib/plugin_live.js')
          end
        
          it "should be named correctly" do
            @file.include?('var LivePlugin').should be_true
          end
        
          it "should apply the js-model plugin" do
            @file.include?('ChocoUtils.modelPlugin(LivePlugin);').should be_true
          end
          
          it "should display the syntax to activate the sammy plugin" do
            @file.include?('// this.use(Sammy.Live);').should be_true
          end
      
        end
        
      end
    end
    
    describe Choco::ScaffoldGenerator do
      describe "with a list of fields" do
        it "should generate a scaffold based on the list of fields given as argument" do
          gen = Choco::ScaffoldGenerator.new(['post', ['author', 'title', 'content']])
          gen.invoke
          
          File.exist?('app/controllers/posts_controller.js').should be_true
          File.exist?('app/models/post.js').should be_true
          File.exist?('app/views/posts/index.template').should be_true
          File.exist?('app/views/posts/show.template').should be_true
          File.exist?('app/views/posts/new.template').should be_true
          File.exist?('app/views/posts/edit.template').should be_true
        end
      end
      
      describe "with a URL" do
        it "should generate a scaffold based on the fields present in the JSON response" do
          url = 'http://localhost:3000/posts'
          gen = Choco::ScaffoldGenerator.new(['post', url])
          json = [{"title" => "Please, contribute!","author" => "antho","content" => "What do you think about Choco?"}]
          
          gen.should_receive(:open).with(url, 'UserAgent' => 'Choco').and_return(StringIO.new)
          JSON.should_receive(:parse).and_return(json)
          
          gen.invoke
          
          gen.keys.should == ["author", "title", "content"]
          File.exist?('app/controllers/posts_controller.js').should be_true
          File.exist?('app/models/post.js').should be_true
          File.exist?('app/views/posts/index.template').should be_true
          File.exist?('app/views/posts/show.template').should be_true
          File.exist?('app/views/posts/new.template').should be_true
          File.exist?('app/views/posts/edit.template').should be_true                              
        end
      end
      
      describe "templates" do
        
        before(:each) do
          gen = Choco::ScaffoldGenerator.new(['post', ['author', 'title', 'content']])
          gen.invoke
        end
        
        it "the index file should have a column for each field" do
          file = get_file_as_string('app/views/posts/index.template')
          file.include?("<th>Author</th>").should be_true
          file.include?("<th>Title</th>").should be_true
          file.include?("<th>Content</th>").should be_true
          file.include?("<td><%= post.attr('author') %></td>").should be_true
          file.include?("<td><%= post.attr('title') %></td>").should be_true
          file.include?("<td><%= post.attr('content') %></td>").should be_true
        end
        
        it "the show file should have a label for each field" do
          file = get_file_as_string('app/views/posts/show.template')
          file.include?("<label>Author</label>").should be_true
          file.include?("<label>Title</label>").should be_true
          file.include?("<label>Content</label>").should be_true
        end
        
        it "the new file should have a field for each field" do
          file = get_file_as_string('app/views/posts/new.template')
          file.include?('<input type="text" name="post[author]"/>').should be_true
          file.include?('<input type="text" name="post[title]"/>').should be_true
          file.include?('<input type="text" name="post[content]"/>').should be_true
        end
        
        it "the edit file should have a field for each field" do
          file = get_file_as_string('app/views/posts/edit.template')
          file.include?(%Q(<input type="text" name="post[author]" value="<%= post.attr('author') %>"/>)).should be_true
          file.include?(%Q(<input type="text" name="post[title]" value="<%= post.attr('title') %>"/>)).should be_true
          file.include?(%Q(<input type="text" name="post[content]" value="<%= post.attr('content') %>"/>)).should be_true
        end
        
      end
    end
  end
end
