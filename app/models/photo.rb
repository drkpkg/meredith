class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :event_id, type: String
  field :description, type: String
  field :likes, type: Array, default: []
  has_mongoid_attached_file :image,
                            processors: [:watermark],
                            styles: {
                                thumb: '150x150',
                                small: '350x300',
                                medium: '550x500',
                                original: {
                                    geometry: '800>',
                                    watermark_path: "#{Rails.root}/public/images/logo.gif"
                                }
                            },
                            :url => "/files/:class/:attachment/:id/:style/:basename.:extension",
                            :path => ":rails_root/public/files/:class/:attachment/:id/:style/:basename.:extension"

  validates_attachment_content_type :image,
                                    :content_type => ["image/jpg", "image/jpeg", "image/png"]
  #validates_uniqueness_of :image_fingerprint, message: "La imagen existe en la galería"

  belongs_to :event

  def image_with_watermark
    converter = ImageObject.new
    self.image.path = converter.add_watermark(self.image.path, ActionController::Base.helpers.asset_path('logo'))
  end

  def has_likes
    return 0 if self.likes.empty?
    self.likes.lenght
  end

end
