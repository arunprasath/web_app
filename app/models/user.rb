class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validate_email_field = false
  end
  
  has_many :products, :through => :accessibles
  has_many :accessibles, :dependent => :destroy

  Role = %w(admin normal_user)

  validates_numericality_of :phone_no
  validates_numericality_of :pincode
  validates_format_of :login, :with => /^[a-zA-Z 0-9]+$/x
  validates_format_of :city, :with => /^[a-zA-Z 0-9]+$/x 

  named_scope :list , :conditions => ["is_deleted = ? AND status = ?", false, 'Active']
  named_scope :inactive_list , :conditions => ["is_deleted = ? AND status = ?", false, 'Inactive']
  
  def is_admin?
    self.role.eql?("admin")
  end
end
