class User < ApplicationRecord

  has_secure_password :validations => false
  has_many :user_roles,dependent: :destroy
  has_many :devices, dependent: :nullify
  after_create :set_emp_id 
  
  before_save {self.email = email.downcase}

  validates :name,presence: true,length: { minimum: 3 } , format: {with: /\A[^0-9`!@#\$%\^&*+_=]+\z/}

  VALID_PHONE_REGIX = /\d[0-9]\)*\z/  
  validates :phone_number,format: { with: VALID_PHONE_REGIX },presence: true, length: { is: 10 },uniqueness: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,presence: true,format: { with: VALID_EMAIL_REGEX},uniqueness: {case_sensitive: false}

  scope :search, ->(search) {(search.nil? ? all : approved.where('lower(name) LIKE lower(?) OR lower(emp_id) LIKE lower(?)', "%#{search}%", "%#{search}%") )}
  scope :approved, -> { where(approved: true).order(:emp_id) }   

private

  def set_emp_id 
    if self.emp_id == nil
      self.update( emp_id:"EMP-#{self.id.to_s.rjust(3,'0')}" )
    end
  end
end
