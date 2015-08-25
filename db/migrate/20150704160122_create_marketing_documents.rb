class CreateMarketingDocuments < ActiveRecord::Migration
  def change
    create_table :marketing_documents do |t|
      t.string :name
      t.string :filename
      t.timestamps null: false
    end
  end
end
