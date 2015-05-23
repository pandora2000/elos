def silently(&block)
  original_stdout, $stdout = $stdout, File.open(File::NULL, 'w')
  original_stderr, $stderr = $stderr, File.open(File::NULL, 'w')
  block.()
ensure
  $stdout = original_stdout
  $stderr = original_stderr
end

database_configurations = {
  adapter: 'mysql2',
  username: 'root',
  password: 'password',
  database: 'elos_test'
}.stringify_keys!

silently do
  ActiveRecord::Tasks::DatabaseTasks.drop(database_configurations)
  ActiveRecord::Tasks::DatabaseTasks.create(database_configurations)
  ActiveRecord::Tasks::DatabaseTasks.migrate
end
