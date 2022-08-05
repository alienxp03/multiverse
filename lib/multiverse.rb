require "multiverse/generators"
require "multiverse/railtie"
require "multiverse/version"

module Multiverse
  class << self
    attr_writer :db

    def db
      @db ||= begin
        if Dir.exist?(db_dir)
          db_env
        else
          warn "Warning: Unknown DB #{db_env}"
          nil
        end
      end
    end

    def db_dir
      "#{Rails.application.config.paths["db"].first}/#{db_env}"
    end

    def parent_class_name
      "#{db.camelize}Record"
    end

    def migrate_path
      "#{db_dir}/migrate"
    end

    def db_env
      ENV["DB"].presence
    end
  end
end
