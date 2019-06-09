class AddOpinionToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :opinion, :text
  end
end
