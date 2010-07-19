class Customer < ActiveRecord::Base
  belongs_to :product
  validates_presence_of :name,:address, :phone_no, :customer_key, :auth_key, :status
  validates_uniqueness_of :auth_key
  #before_create :set_auth_key
  
  named_scope :list, :conditions => ["is_deleted=?",false]
  
  def set_auth_key
    self.auth_key = Digest::SHA1.hexdigest(Time.now.to_s + rand(12341234).to_s)[1..8]
  end
end
