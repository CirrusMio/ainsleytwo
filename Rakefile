desc 'Get new secure key'
task :secret do
  require 'securerandom'
  puts SecureRandom.hex
end

desc 'load batch secrets from json'
task :load_secrets do
  require 'pstore'
  require 'multi_json'

  store = PStore.new('whitelist.pstore')
  begin
    keys = MultiJson.load(File.open('whitelist.json'), symbolize_keys: true)
    keys.each do |key,val|
      store.transaction do
        store["#{key.to_s}"] = val
      end
    end
  rescue MultiJson::ParseError => exception
    exception.data
    exception.cause
  end
end
