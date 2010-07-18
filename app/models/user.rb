class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validate_email_field = false
  end

  has_many :products, :through => :accessibles
  has_many :accessibles, :dependent => :destroy

  Role = %w(admin normal_user)

  def is_admin?
    self.role.eql?("admin")
  end
end
