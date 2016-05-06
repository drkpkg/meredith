require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include BCrypt

  #Accessors
  attr_accessor :password, :password_confirmation

  #Paperclip attachment
  has_mongoid_attached_file :avatar,
                            styles: {
                                thumb: '150x150',
                                small: '350x300',
                                medium: '550x500',
                                original: {
                                    geometry: '800>'
                                }
                            },
                            :url => "/files/:class/:attachment/:id/:style/:basename.:extension",
                            :path => ":rails_root/public/files/:class/:attachment/:id/:style/:basename.:extension"

  #Data model
  field :email, type: String
  field :password_hash, type: String
  field :user_type, type: String
  field :terms, type: Boolean
  field :country, type: String
  field :follow_users, type: Array, default: []
  field :address, type: String, default: ''
  field :alias, type: String, default: ''
  field :name, type: String, default: ''
  field :sex, type: String, default: ''
  field :lastname, type: String, default: ''
  field :phones, type: Array, default: []
  field :social_networks, type: Hash, default: {'Facebook':'','Twitter':'','Instagram':'', 'Pinterest':'', 'Tumblr':''}
  field :is_profile_complete, type: Boolean, default: false
  
  #Relations
  has_many :events, dependent: :delete
  #Uniqueness validators
  validates_uniqueness_of :email, message: "Email ya está en uso", on: :create
  validates_acceptance_of :terms, accept: true, message: "Tiene que aceptar los términos de uso", on: :create
  validates_presence_of :email, message: "Email no puede estar vacío", on: :create
  validates_presence_of :password, :password_confirmation, message: "Campo de contraseña en blanco", on: :create
  validates_length_of :password, :password_confirmation, minimum: 6, message: "La contraseña no puede tener menos de 6 caracteres", on: :create
  validate :password_equality, on: :create

  validate :is_phone_correct_format, on: :update
  validates_presence_of :name, message: "Nombre no puede estar vacío", on: :update
  validates_presence_of :lastname, message: "Apellido no puede estar vacío", on: :update
  validates_presence_of :sex, message: "Tiene que seleccionar un género", on: :update
  validates_presence_of :address, message: "Dirección no puede estar vacía", on: :update
  validates_format_of :email, with:  /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: "Formato de correo no válido", on: :update
  validates_format_of :name, with:  /\A([a-z A-Z]*)\Z/i, message: "Nombre solo debe contener letras", on: :update
  validates_format_of :lastname, with:  /\A([a-z A-Z]*)\Z/i, message: "Apellido solo debe contener letras", on: :update
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def profile_is_complete
    if !(self.name.blank? and self.lastname.blank? and self.alias.blank? and self.avatar.blank? and self.sex.blank? and self.address.blank?)
      self.is_profile_complete = true
    end
  end

  def password_equality
    errors.add(:password, "Las contraseñas no coinciden") if password != password_confirmation
  end

  def is_phone_correct_format
    format = /(([(])([+])([0-9]{3})([)])-?)?([0-9]{7,8})/
    self.phones.each do |phone|
      if !phone.match(format)
        errors.add(:phones_list, "Formato de telefono incorrecto \n el formato aceptado es: (+123)12345678 o 12345678")
        break
      end
    end
  end

  def phones_list=(arg)
    if !arg.nil?
      arg.each do |value|
        self.phones.push(value)
      end
      self.phones = self.phones.uniq
    end
  end

  def phones_list
    self.phones.join(', ')
  end

  def has_follow_users
    self.follow_users.length
  end

  def social_networks_list=(social_networks)
    self.social_networks = social_networks
  end

  def social_networks_list
    self.social_networks
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def complete_name
    self.name + " " + self.lastname
  end

  def sex_humanize
    return 'Hombre' if self.sex=='h'
    return 'Mujer' if self.sex=='f'
  end

  def total_of_galleries
    galleries = Event.where(user_id: self.id).count
  end

  def total_of_photos
    galleries = Event.where(user_id: self.id)
    total = 0
    galleries.each do |gallery|
      total = total + Photo.where(event_id: gallery.id).count
    end
    total
  end

  def total_of_medium_images_per_gallery
    galleries = Event.where(user_id: self.id)
    total = 0
    galleries.each do |gallery|
      total = total + Photo.where(event_id: gallery.id).count
    end
    total/galleries.count
  end
end