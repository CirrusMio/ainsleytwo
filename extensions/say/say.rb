module Say
  extend AinsleyTwo::Extension

  def self.absorbable
    [:web]
  end

  module Web
    def self.absorb(app)
      whitelist_path = File.join(AinsleyTwo.app_root, 'whitelist.yml')
      if File.exist?(whitelist_path)
        whitelist = YAML.load_file(whitelist_path)
      else
        whitelist = []
      end
      app.set(:whitelist, whitelist)

      say = lambda do
        if params && whitelist.include?(params[:token])
          `say #{params[:words]}`
        else
          halt 403
        end
      end

      app.get '/say', &say
      app.post '/say', &say

      # Return a key if the incoming request is from an internal network
      # Save the key to the whitelist
      app.get '/key' do
        if subnet=settings.config['subnet']
          internal = IPAddr.new(subnet)
          incoming = IPAddr.new(request.ip)
          if internal.include?(incoming)
            key = SecureRandom.hex
            settings.whitelist ||= []
            settings.whitelist.push(key)
            File.open('whitelist.yml', 'w+') do |f|
              f.write(settings.whitelist.to_yaml)
            end
            # Return the key
            key
          end
        end
      end
    end
  end
end

AinsleyTwo.absorb(Say)
