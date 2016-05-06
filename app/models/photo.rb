class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :event_id, type: String
  field :description, type: String
  field :likes, type: Array, default: []
  has_mongoid_attached_file :image_original,
                            :url => "/files/:class/:attachment/:id/:style/:basename.:extension",
                            :path => ":rails_root/public/files/:class/:attachment/:id/:style/:basename.:extension" ,
                            :preserve_files => "false"

  has_mongoid_attached_file :image_processed,
                            processors: [:watermark],
                            styles: {
                                thumb: ['150x150', :jpg],
                                small: ['350x300', :jpg],
                                medium: ['550x500', :jpg],
                                original: {geometry: '60%',watermark_path: "#{Rails.root}/public/images/logo.gif", position: "Center"}
                            },
                            :url => "/files/:class/:attachment/:id/:style/:basename.:extension",
                            :path => ":rails_root/public/files/:class/:attachment/:id/:style/:basename.:extension",
                            :preserve_files => "false"

  validates_attachment_size :image_original,
                            :in => 0.megabytes..500.megabytes,
                            message: "El tamaño del archivo es muy grande"

  validates_attachment_file_name :image_original,
                                 matches: [/png\Z/, /jpe?g\Z/, /iiq\Z/, /IIQ\Z/],
                                 message: "Formato no válido de imagen"

  validates_attachment_content_type :image_original,
                                    content_type: /\Aimage/,
                                    message: "El archivo no es una imagen"

  belongs_to :event

  before_destroy :delete_all_shit

  def has_likes
    return 0 if self.likes.empty?
    self.likes.lenght
  end
  
  def original_size
    Paperclip::Geometry.from_file(self.image_original.path)
  end

  def delete_all_shit
    File.delete(Rails.root + "public/files/photos/original/#{self.id}/*")
    File.delete(Rails.root + "public/files/photos/processed/#{self.id}/*")
  end

end
