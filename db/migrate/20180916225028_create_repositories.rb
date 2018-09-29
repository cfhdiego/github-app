class CreateRepositories < ActiveRecord::Migration[5.0]
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :github_url
      t.string :language
      t.text :description
      t.string :site_url
      t.integer :stars_count
      t.integer :watchers_count
      t.integer :forks_count
      t.index :language

      t.timestamps
    end
  end
end
