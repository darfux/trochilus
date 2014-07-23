class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :attachment_owner, polymorphic: true
      t.timestamps
    end
    add_index :attachments, ["attachment_owner_id", "attachment_owner_type"], :name => 'index_attachments_on_its_owner_id_and_owner_type'
  end
end
