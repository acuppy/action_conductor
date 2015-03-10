require 'rails/generators'
require 'rails/generators/migration'

module ActionConductor
  module Generators
    class ConductorGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("../templates", __FILE__)

      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end

      def copy_migration
        migration_template 'migration.rb', "db/migrate/create_.rb"
      end
    end
  end
end
