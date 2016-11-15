class AddAttachmentPictureToProfilePictures < ActiveRecord::Migration
  def self.up
    change_table :profile_pictures do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :profile_pictures, :picture
  end
end
