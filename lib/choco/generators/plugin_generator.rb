module Choco
  class PluginGenerator < Thor::Group
    include Thor::Actions
    
    def self.source_root
      File.dirname(__FILE__)
    end
    
    desc 'Generates a Choco plugin (Sammy or js-model)'
    argument :name
    class_option :for_lib
    
    def create_model_file
      @plugin_name = name.camelcase.singularize
      @name = name.underscore.singularize
      template('templates/lib/plugin.js', "lib/plugin_#{@name}.js")
    end
    
  end
end
