class User < ActiveRecord::Base
  
  attr_accessible :name, :email, :password, :password_confirmation
  
  validates_presence_of     :email
  validates_presence_of     :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_uniqueness_of   :email, :case_sensitive => false
  validates_format_of       :email, :with => %r{.+@.+\..+}
  
  def self.authenticate(email, password)
    return nil  unless user = find_by_email(email)
    return user if     user.authenticated?(password)
  end
  
  def authenticated?(incoming_pw)
    !password.blank? && !incoming_pw.blank? && password == incoming_pw
  end

protected
  
  def password_required?
    true #!password.blank?
  end

end
