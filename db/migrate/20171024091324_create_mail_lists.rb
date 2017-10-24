class CreateMailLists < ActiveRecord::Migration[5.1]
  def change
    create_table :mail_lists do |t|
      t.string :subject
      t.text :message
      t.string :from_addr
      t.string :to_addr
      t.datetime :date
      t.references :logins, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end
