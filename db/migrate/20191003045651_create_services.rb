class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :ccs_service_id
      t.string :api_dom

      t.timestamps
    end
  end
end
