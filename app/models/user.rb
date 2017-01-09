class User < ActiveRecord::Base
	rolify

  extend FriendlyId
  friendly_id :full_name, use: [:slugged,:finders]  
	
  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  enum user_role: [:admin, :user, :superadmin, :customer]

  scope :filter, lambda { |column , value| where("#{column} like ?", "%#{value}%") }
  
  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def should_generate_new_friendly_id?
    new_record? || self.slug.nil? || self.slug.blank? || (self.first_name.present? && self.last_name.present?)# you can add more condition here
  end
end