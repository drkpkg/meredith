require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include BCrypt

  #Accessors
  dragonfly_accessor :image
  attr_accessor :password, :password_confirmation

  #Data model
  field :image_uid, type: String
  field :alias, type: String
  field :name, type: String
  field :sex, type: String
  field :lastname, type: String
  field :email, type: String
  field :password_hash, type: String
  field :phones, type: Array, default: []
  field :social_networks, type: Hash, default: {}
  field :social_events, type: Array, default: []
  field :terms, type: Boolean
  field :user_type, type: String

  #Relations
  has_many :events, dependent: :delete

  #Uniqueness validators
  validates_uniqueness_of :email, message: "Email ya está en uso"  
  #Acceptance validators
  validates_acceptance_of :terms, accept: true, message: "Tiene que aceptar los términos de uso"  
  #Presence validators
  validates_presence_of :password, :password_confirmation, message: "Campo de contraseña en blanco", on: :create
  validates_presence_of :name, message: "Nombre no puede estar vacío", on: :update 
  validates_presence_of :lastname, message: "Apellido no puede estar vacío", on: :update
  validates_presence_of :email, message: "Email no puede estar vacío", on: :update  
  #Format validators
  validates_format_of :email, with:  /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: "Formato de correo no válido"
  validates_format_of :name, with:  /\A([a-z A-Z]*)\Z/i, message: "Nombre solo debe contener letras", on: :update
  validates_format_of :lastname, with:  /\A([a-z A-Z]*)\Z/i, message: "Apellido solo debe contener letras", on: :update  
  #Lenght validators
  validates_length_of :password, :password_confirmation, minimum: 6, message: "La contraseña no puede tener menos de 6 caracteres" 
  #Custom validators
  validate :password_equality
  
  def password_equality
      errors.add(:password, "Las contraseñas no coinciden") if password != password_confirmation
  end

  def phones_list=(arg)
    self.phones = arg.split(',').map { |v| v.strip }
  end

  def phones_list
    self.phones.join(', ')
  end

  def social_networks_list=(arg)
    self.social_networks = arg.split(',').map { |v| v.strip }
  end

  def social_networks_list
    self.social_networks.join(', ')
  end
  
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end