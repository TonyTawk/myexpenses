class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.decimal :amount
      t.datetime :time
      t.string :type

      t.timestamps
    end
  end
end
