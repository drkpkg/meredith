class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :user_id, type: String
  field :event_name, type: String  
  field :event_description, type: String
  field :event_photos, type: Array, default: []

  belongs_to :user
  has_many :photos, dependent: :delete
  
  validates_uniqueness_of :event_name, sensitive: false, message: "El nombre de la galería debe ser único"
  validates_presence_of :event_name, message: "El nombre de la galería no puede estar vacío"
end
