module Authentication
  def authenticate(token)
    whitelist = YAML.load_file(File.expand_path('whitelist.yml'))
    whitelist.include?(token)
  end
end
