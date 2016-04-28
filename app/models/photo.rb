class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  has_mongoid_attached_file :photo
  
  field :event_id, type: String
  field :description, type: String

  belongs_to :event
  
end
