class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :user_id, type: String
  field :event_name, type: String  
  field :event_description, type: String
  field :event_code, type: String

  belongs_to :user
  has_many :photos, dependent: :delete
  
  validates_uniqueness_of :event_name, sensitive: false, message: "El nombre de la galería debe ser único"
  validates_presence_of :event_name, message: "El nombre de la galería no puede estar vacío"

  before_destroy :delete_photos_data
  before_create :generate_code

  def total_photos
    Photo.where(event_id: self.id).count
  end

  private

  def generate_code
    self.event_code = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
  end

  def delete_photos_data
    photos = Photo.where(event_id: self.id)
    photos.each do |photo|
      FileUtils.rm_rf("#{Rails.root}/public/files/photos/image_originals/#{photo.id}")
      FileUtils.rm_rf("#{Rails.root}/public/files/photos/image_processeds/#{photo.id}")
    end
  end
end
