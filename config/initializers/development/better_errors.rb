if defined? BetterErrors
  # Private subnets defined by RFC1918 as stated in https://docs.docker.com/v1.5/articles/networking/
  BetterErrors::Middleware.allow_ip! '10.0.0.0/8'
  BetterErrors::Middleware.allow_ip! '172.16.0.0/12'
  BetterErrors::Middleware.allow_ip! '192.168.0.0/16'

  # Opening files
  #
  # SAMPLE: config/settings/development.local.yml
  #
  #   better_errors:
  #     app_dir: '/Users/yonyon/src/github.com/yonyonko/assembly'
  #     editor: 'x-mine://open?file=%s&line=%s'
  #
  if Settings.better_errors_editor.present?
    BetterErrors.editor = proc { |full_path, line|
      full_path = full_path.sub(Rails.root.to_s, ENV['DOCKER_HOST_PATH']) if ENV['DOCKER_HOST_PATH']
      Settings.better_errors_editor % [full_path, line]
    }
  end
end
