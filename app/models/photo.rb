class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  has_mongoid_attached_file :image, styles: {thumb: '150x150', small: '350x300', medium: '550x500'},:url => "/files/:class/:attachment/:id/:style/:basename.:extension", :path => ":rails_root/public/files/:class/:attachment/:id/:style/:basename.:extension"
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  field :event_id, type: String
  field :description, type: String

  belongs_to :event

  def image_url
    image.url(:medium)
  end

end
