class CreateMunicipalities < ActiveRecord::Migration[5.2]
  def change
    create_table :municipalities do |t|
        t.string :name
        t.string :filt_string
        t.timestamps
    end
  end
end
