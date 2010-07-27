module Choco
  class FixtureGenerator < Thor::Group
    include Thor::Actions
    
    def self.source_root
      File.dirname(__FILE__)
    end
    
    desc 'Generates Ajax fixtures (mocks)'
    argument :name, :required => true    
    
    def create_mock_file
      @name = name.underscore.pluralize
      template('templates/fixtures/base.js', "fixtures/#{@name}.js")
    end
    
    def create_json_folder
      empty_directory "fixtures/#{@name}"
      template('templates/fixtures/model/array.js', "fixtures/#{@name}/#{@name}.json")
    end
    
  end
end
