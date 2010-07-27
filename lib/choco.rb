require 'thor'
require 'thor/group'
require 'active_support/inflector'

module Choco
  VERSION = '0.1.2'
  
  autoload :DependencyManager, 'choco/dependency_manager'
  autoload :CLI, 'choco/cli'  
  autoload :AppGenerator, 'choco/generators/app_generator'
  autoload :ControllerGenerator, 'choco/generators/controller_generator'
  autoload :LayoutGenerator, 'choco/generators/layout_generator'
  autoload :FixtureGenerator, 'choco/generators/fixture_generator'  
  autoload :ModelGenerator, 'choco/generators/model_generator'
  autoload :PluginGenerator, 'choco/generators/plugin_generator'
  autoload :ScaffoldGenerator, 'choco/generators/scaffold_generator'          
end