class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  dragonfly_accessor :photo

  field :photo_uid, type: String
  field :photo_name, type: String
  field :description, type: String

  belongs_to :event
end
