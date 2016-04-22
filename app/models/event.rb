class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :event_description, type: String
  field :event_photos, type: Array, default: []

  belongs_to :user
  has_many :photos, dependent: :delete
end
