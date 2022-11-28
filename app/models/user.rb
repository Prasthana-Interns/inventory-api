class User < ApplicationRecord

  

  has_secure_password
  after_save :set_emp_id 
  before_save {self.email = email.downcase}

    def set_emp_id 
      if self.emp_id == nil
       self.update( emp_id:"EMP-#{self.id.to_s.rjust(3,'0')}" )
      end
    end
 
  validates :name,presence: true,length: {minimum: 3},format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/ }

  VALID_PHONE_REGIX = /\d[0-9]\)*\z/  
  validates :phone_number,format: { with: VALID_PHONE_REGIX },presence: true,length: {minimum:10 ,maximum: 10}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,presence: true,format: { with: VALID_EMAIL_REGEX},uniqueness: {case_sensitive: false}
end
