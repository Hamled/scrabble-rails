class CreateTileBags < ActiveRecord::Migration[5.1]
  def change
    create_table :tile_bags do |t|
      t.string :tiles, null: false, default: ''
      t.timestamps
    end
  end
end
