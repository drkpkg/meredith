class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :event_id, type: String
  field :description, type: String

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

  belongs_to :event

  def image_with_watermark
    converter = ImageObject.new
    self.image.path = converter.add_watermark(self.image.path, ActionController::Base.helpers.asset_path('logo'))
  end

end
