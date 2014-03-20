class AinsleyTwo

  # Set required arguments for absorbable functionality
  def self.functionality
    {web: [Web]}
  end
  
  # Register an extension
  def self.absorb mod
    # Iterate through each absorbable module, absorbing
    # available functionality
    mod.absorbable.each do |absorbable|
      mod.absorbing(absorbable, functionality[absorbable])
    end
  end

  # Extension helpers
  module Extension
    def absorbing(absorbable, functionality)
      mod = Kernel.const_get(self.name.to_sym)
      absorbable_name = absorbable.to_s.capitalize.to_sym
      absorbable_mod = mod.const_get(absorbable_name)

      # Extend respective AinsleyTwo extension
      ainsley_class = AinsleyTwo.const_get(absorbable_name)
      ainsley_class.extend(absorbable_mod)

      absorbable_mod.absorb(*functionality)
    end
  end

  # Load some configuration
  def self.config
    @config ||= YAML.load_file('config.yml')
  end

  # Set the application root directory
  def self.app_root
    File.join(File.dirname(__FILE__), '..')
  end

  # Sinatra support
  class Web < Sinatra::Base
    set :config, AinsleyTwo.config

    get '/' do
      'Hello. I am AinsleyTwo.'
    end
  end
end
