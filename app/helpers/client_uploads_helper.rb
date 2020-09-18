# frozen_string_literal: true

module ClientUploadsHelper
  def file_upload_types
    ClientUpload.file_types.to_a.map do |t|
      OpenStruct.new(label: ClientUpload.human_enum_name(:file_type, t[0]), value: t[1])
    end
  end
end
