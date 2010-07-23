module Choco
  class AppGenerator < Thor::Group
    include Thor::Actions
    
    def self.source_root
      File.dirname(__FILE__)
    end
    
    desc 'Generates a delicious Choco app'
    argument :name
    
    def create_root_folder
      empty_directory name
    end
    
    def create_app_folder
      empty_directory "#{name}/app"
      empty_directory "#{name}/app/controllers"
      empty_directory "#{name}/app/models"
      empty_directory "#{name}/app/views"
      empty_directory "#{name}/app/views/main"        
      empty_directory "#{name}/app/views/layouts"        
      empty_directory "#{name}/app/helpers"
      
      template('templates/controllers/application_controller.js', "#{name}/app/controllers/application_controller.js")
      template('templates/views/main/index.template', "#{name}/app/views/main/index.template")        
      template('templates/helpers/application_helper.js', "#{name}/app/helpers/application_helper.js")
    end
    
    def create_lib_folder
      empty_directory "#{name}/lib"
    end
    
    def create_compressed_folder
      empty_directory "#{name}/compressed"
    end
    
    def create_images_folder
      empty_directory "#{name}/images"
    end
    
    def create_stylesheets_folder
      empty_directory "#{name}/stylesheets"
      template('templates/application.css', "#{name}/stylesheets/application.css")
    end
    
    def create_spec_folder
      empty_directory "#{name}/spec"
    end
    
    def create_script_folder
      empty_directory "#{name}/script"
      template('templates/choco', "#{name}/script/choco")
    end      
    
    def create_jimfile
      template('templates/Jimfile', "#{name}/Jimfile")
    end
    
    def create_rakefile
      template('templates/Rakefile', "#{name}/Rakefile")
    end
    
    def create_readme_file
      create_file "#{name}/README.rdoc"
    end
    
    def create_index_file
      template('templates/index.html', "#{name}/index.html")
    end
  end
end
