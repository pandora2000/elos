class CreateAEntryRepos < ActiveRecord::Migration
  def change
    create_table :a_entry_repos do |t|
      t.string :title
    end
  end
end
