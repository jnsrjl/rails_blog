class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    # Need to fetch by date created
    add_index :blogs, [:created_at]
  end
end
