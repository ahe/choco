require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Choco::DependencyManager do
  
  def in_file(file, dependency, after = '')
    i = 0
    after_after = false
    
    File.new(file, "r").each do |line|
      after_after = true if line.include?(after)
      if after != ''
        i += 1 if after_after && line.include?(dependency)
      else
        i += 1 if line.include?(dependency)
      end
    end
    i
  end
  
  before(:each) do
    @project_path = 'spec/tmp/test_project'
    Choco::AppGenerator.start @project_path
    FileUtils.cd(@project_path)
  end
  
  after(:each) do
    FileUtils.cd('../../..')
    FileUtils.rm_rf(@project_path)
  end
  
  describe "adding dependencies" do
    
    describe "when it's a controller" do
      
      it "should add an entry in the Jimfile (controllers section)" do
        in_file('Jimfile', 'app/controllers/posts_controller').should == 0
        Choco::DependencyManager.add_dependency('app/controllers/posts_controller.js')
        in_file('Jimfile', 'app/controllers/posts_controller', "// Controllers # Don't remove this line!").should == 1
      end
      
      it "should configure it in the application controller" do
        in_file('app/controllers/application_controller.js', 'ArticlesController(this);').should == 0
        Choco::DependencyManager.add_dependency('app/controllers/articles_controller.js')
        in_file('app/controllers/application_controller.js', 
                'ArticlesController(this);', 
                "/* Configure your controllers here ### Don't remove this line! */").should == 1
      end
      
    end
    
    describe "when it's a model" do
      
      it "should add an entry in the Jimfile (models section)" do
        in_file('Jimfile', 'app/models/post').should == 0
        Choco::DependencyManager.add_dependency('app/models/post.js')
        in_file('Jimfile', 'app/models/post', "// Models # Don't remove this line!").should == 1
      end
      
    end
    
    describe "when it's a helper" do
      
      it "should add an entry in the Jimfile (helpers section)" do
        in_file('Jimfile', 'app/helpers/test').should == 0
        Choco::DependencyManager.add_dependency('app/helpers/test.js')
        in_file('Jimfile', 'app/helpers/test', "// Helpers # Don't remove this line!").should == 1
      end
      
    end
    
    describe "when it's a fixture" do
      
      it "should add an entry in the Jimfile (models section)" do
        in_file('Jimfile', 'fixtures/posts').should == 0
        Choco::DependencyManager.add_dependency('fixtures/posts.js')
        in_file('Jimfile', 'fixtures/posts', "// Fixtures # Don't remove this line!").should == 1
      end
      
    end
    
    describe "when it's a lib" do
      
      it "should add an entry in the Jimfile (libs section)" do
        in_file('Jimfile', 'lib/my_lib').should == 0
        Choco::DependencyManager.add_dependency('lib/my_lib.js')
        in_file('Jimfile', 'lib/my_lib', "// Libs # Don't remove this line!").should == 1
        
        in_file('Jimfile', 'another/file').should == 0
        Choco::DependencyManager.add_dependency('another/file.js')
        in_file('Jimfile', 'another/file', "// Libs # Don't remove this line!").should == 1
      end
      
    end
    
  end
  
  describe "removing dependencies" do
    
    it "should remove the dependency from the jimfile" do
      Choco::DependencyManager.add_dependency('app/models/post.js')
      in_file('Jimfile', 'app/models/post').should == 1
      Choco::DependencyManager.remove_dependency('app/models/post.js')
      in_file('Jimfile', 'app/models/post').should == 0
    end
    
    describe "when it's a controller" do
      it "should remove the configuration from the application controller" do
        Choco::DependencyManager.add_dependency('app/controllers/articles_controller.js')
        in_file('app/controllers/application_controller.js', 'ArticlesController(this);').should == 1
        Choco::DependencyManager.remove_dependency('app/controllers/articles_controller.js')
        in_file('app/controllers/application_controller.js', 'ArticlesController(this);').should == 0
      end
    end
    
    describe "when it's a model" do
      it "should not change empty the application controller" do
        Choco::DependencyManager.remove_dependency('app/models/article.js')
        in_file('app/controllers/application_controller.js', 'var app = $.sammy(function() {').should == 1
      end
    end
    
  end
end