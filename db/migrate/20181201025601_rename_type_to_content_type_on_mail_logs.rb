class RenameTypeToContentTypeOnMailLogs < ActiveRecord::Migration[5.2]
  def change
    rename_column :mail_logs, :type, :content_type
  end
end
