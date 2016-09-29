class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :blog, index: true, foreign_key: true

      t.timestamps null: false
    end

    # Index by blog_id or created_at
    add_index :posts, [:blog_id, :created_at]
  end
end
