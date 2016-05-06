class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :event_id, type: String
  field :description, type: String
  field :likes, type: Array, default: []
  has_mongoid_attached_file :image_original, 
                            styles:{
                                original: ["100%",:jpg]
                            },
                            :url => "/files/:class/:attachment/original/:id/:style/:basename.:extension",
                            :path => ":rails_root/public/files/:class/:attachment/original/:id/:style/:basename.:extension"

  has_mongoid_attached_file :image_processed,
                            processors: [:watermark],
                            styles: {
                                thumb: ['150x150', :jpg],
                                small: ['350x300', :jpg],
                                medium: ['550x500', :jpg],
                                original: [{
                                    geometry: '60%',
                                    watermark_path: "#{Rails.root}/public/images/logo.gif", position: "Center"
                                }, :jpg]
                            },
                            :url => "/files/:class/:attachment/processed/:id/:style/:basename.:extension",
                            :path => ":rails_root/public/files/:class/:attachment/processed/:id/:style/:basename.:extension"

  
  validates_attachment_size :image_original, :image_processed, :in => 0.megabytes..500.megabytes
  validates_attachment_content_type :image_original, :image_processed,
                                    :content_type => ["image/jpg", "image/jpeg", "image/png", "image/tif"], message: "Formato incorrecto"
  
  belongs_to :event

  def has_likes
    return 0 if self.likes.empty?
    self.likes.lenght
  end
  
  def original_size
    Paperclip::Geometry.from_file(self.image_original.path)
  end

end
