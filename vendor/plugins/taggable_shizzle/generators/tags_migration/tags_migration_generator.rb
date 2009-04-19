class TagsMigrationGenerator < Rails::Generator::Base
  def manifest
    recorded_session = record do |m|
      m.migration_template 'migration.rb', 'db/migrate', :assigns => {
        :migration_name => "AddTaggingTables"
      }, :migration_file_name => "add_tagging_tables"
    end

    recorded_session
  end
end
