class CreateTimeModels < ActiveRecord::Migration[5.2]
  def change
    create_table :time_models do |t|
      t.atomic_time :start_time
      t.atomic_time :end_time
      t.timestamps

      puts "PRIMARY KEYS: #{t.primary_keys}"
      puts "COLUMNS: #{t.columns}"
    end
  end
end
