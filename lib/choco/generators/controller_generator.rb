module Choco
  class ControllerGenerator < Thor::Group
    include Thor::Actions
    
    def self.source_root
      File.dirname(__FILE__)
    end
    
    desc 'Generates a Choco controller'
    argument :name
    
    def create_controller_file
      template('templates/controllers/base_controller.js', "app/controllers/#{name.underscore}_controller.js")
    end
    
    def create_views_folder
      empty_directory "app/views/#{name.underscore}"
    end
    
  end
end
