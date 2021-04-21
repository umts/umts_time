class CreateTimeModels < ActiveRecord::Migration[5.2]
  def change
    create_table :time_models do |t|
      t.integer :start_time
      t.integer :end_time
      t.timestamps
    end
  end
end
