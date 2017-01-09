class Inquiry < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :phone,:length=>{:maximum => 10, :allow_nil => true}

  scope :filter,lambda { |column , value| where("#{column} like ?", "%#{value}%") } 
end
