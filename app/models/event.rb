class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :user_id, type: String
  field :event_name, type: String  
  field :event_description, type: String

  belongs_to :user
  has_many :photos, dependent: :delete
  
  validates_uniqueness_of :event_name, sensitive: false, message: "El nombre de la galería debe ser único"
  validates_presence_of :event_name, message: "El nombre de la galería no puede estar vacío"
  
  #before_create :set_gallery_folder
  
  def total_photos
    Photo.where(event_id: self.id).count
  end
  
  def set_gallery_folder
    FileUtils.mkdir("#{Rails.root}/public/files/photos/#{self.id}")    
  end
  
  def delete_folder
    FileUtils.rm_rf("#{Rails.root}/public/files/photos/#{self.id}")
    FileUtils.rm_rf("#{Rails.root}/public/files/photos/#{self.id}")
  end
end
