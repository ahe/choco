require 'pathname'

module Choco
  
  class CLI
    
    def initialize(args)
      @args   = args
      @output = ""
    end
    
    def run
      @args << '--help' if @args.empty?

      aliases = {
        "g"  => "generate",
        "s"  => "server"
      }

      command = @args.shift
      command = aliases[command] || command

      case command
        when 'generate'
          name = @args.shift
          if name
            klass = eval("Choco::#{name.capitalize}Generator")
            klass.start @args
          else
            @output = template('generators')
          end
        
        when 'server'
          port = 9292
          port = @args[@args.index('-p') + 1] if @args.include?('-p')
          port = @args[@args.index('--port') + 1] if @args.include?('--port')
          puts "*** Choco server is now running on port #{port}"
          puts "*** Launch http://localhost:#{port}/index.html to start your Choco application"
          system "rackup #{@args.join(' ')}"

        when '--watch'
          require 'fssm'

          puts "*** Choco is now watching your JS files..."

          system "jim bundle #{Choco::DependencyManager.to}"

          FSSM.monitor(Dir.pwd, ['**/*.js', 'Jimfile']) do
            update do |base, relative|
              unless relative.include?('bundled.js')
                puts "*** #{relative} changed!"
                system "jim bundle #{Choco::DependencyManager.to}"
              end
            end

            create do |base, relative|
              unless relative.include?('bundled.js')
                puts "*** #{relative} created!"
                Choco::DependencyManager.add_dependency(relative)
                system "jim bundle #{Choco::DependencyManager.to}"
              end
            end

            delete do |base, relative|
              puts "*** #{relative} deleted!"
              Choco::DependencyManager.remove_dependency(relative)
              system "jim bundle #{Choco::DependencyManager.to}"
            end
          end
        else
          @output = template('commands')
      end
      
      @output
    end
    
    private
    
    def template(path)
      (Pathname.new(__FILE__).dirname + 'generators/templates/help/' + path).read
    end
    
  end
end