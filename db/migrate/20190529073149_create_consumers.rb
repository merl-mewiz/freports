class CreateConsumers < ActiveRecord::Migration[5.2]
  def change
    create_table :consumers do |t|
        t.belongs_to :municipality, index: true
        t.string :name
        t.timestamps
    end
  end
end
