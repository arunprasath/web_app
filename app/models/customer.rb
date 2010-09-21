class Customer < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates_presence_of :name,:address, :phone_no, :customer_key, :auth_key, :status
  validates_uniqueness_of :auth_key
  #before_create :set_auth_key
  validates_numericality_of :phone_no, :only_integer => true
  validates_numericality_of :pincode, :only_integer => true
  validates_format_of :name, :with => /^[a-zA-Z 0-9]+$/x
  validates_format_of :city, :with => /^[a-zA-Z 0-9]+$/x
  validates_format_of :contact_person, :with => /^[a-zA-Z 0-9]+$/x 
  
  named_scope :list, :conditions => ["is_deleted=? AND status = ?",false, 'Active']
  named_scope :restricted_list, lambda {|user| {:conditions => ["is_deleted=? AND status = ? AND user_id = ?",false, 'Active', user]}}
  named_scope :inactive_list, :conditions => ["is_deleted=? AND status = ?",false, 'Inactive']
  named_scope :restricted_inactive_list, lambda {|user| {:conditions => ["is_deleted=? AND status = ? AND user_id = ?",false, 'Inactive', user]}}
  
  def set_auth_key
    self.auth_key = Digest::SHA1.hexdigest(Time.now.to_s + rand(12341234).to_s)[1..8]
  end
end
