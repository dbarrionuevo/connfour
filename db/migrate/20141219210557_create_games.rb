class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.belongs_to :user, index: true

      t.integer :column
      t.integer :row
    end
  end
end
