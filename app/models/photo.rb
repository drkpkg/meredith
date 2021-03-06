class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :event_id, type: String
  field :description, type: String
  field :likes, type: Array, default: []
  field :image_original, type: String

  # has_mongoid_attached_file :image_original,
  #                           :url => "/files/:class/:attachment/:id/:style/:basename.:extension",
  #                           :path => ":rails_root/public/files/:class/:attachment/:id/:style/:basename.:extension"

  has_mongoid_attached_file :image_processed,
                            processors: [:watermark],
                            styles: {
                                thumb: ['150x150', :jpg],
                                small: ['350x300', :jpg],
                                medium: ['550x500', :jpg],
                                original: {geometry: '60%',watermark_path: "#{Rails.root}/public/images/logo.gif", position: "Center"}
                            },
                            :url => "/files/:class/:attachment/:id/:style/:basename.:extension",
                            :path => ":rails_root/public/files/:class/:attachment/:id/:style/:basename.:extension"

  validates_attachment_size :image_processed,
                            :in => 0.megabytes..500.megabytes,
                            message: "El tamaño del archivo es muy grande"

  validates_attachment_file_name :image_processed,
                                 matches: [/png\Z/, /jpe?g\Z/],
                                 message: "Formato no admitido"

  validates_attachment_content_type :image_processed,
                                    content_type: /\Aimage/,
                                    message: "El archivo no es una imagen"

  # validates_uniqueness_of :image_original_fingerprint, message: "La imagen ya la subieron :v"

  belongs_to :event

  before_destroy :delete_photo_data

  def has_likes
    return 0 if self.likes.empty?
    return self.likes.length
  end
  
  def original_resolution
    Paperclip::Geometry.from_file(self.image_original.path)
  end

  def original_file_size_in_kb
    self.image_original_file_size/1000 
  end

  private

  def delete_photo_data
    FileUtils.rm_rf("#{Rails.root}/public/files/photos/image_originals/#{self.id}")
    FileUtils.rm_rf("#{Rails.root}/public/files/photos/image_processeds/#{self.id}")
  end
  
end