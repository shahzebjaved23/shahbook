class AddReplyOfCommentIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :reply_of_comment_id, :integer
  end
end
