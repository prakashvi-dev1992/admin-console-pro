class StaticPage < ActiveRecord::Base

  validates :name, :presence => true
  validates :page_route, :presence => true
  validates :label, :presence => true
  validates_uniqueness_of :label

  scope :filter,lambda { |column , value| where("#{column} like ?", "%#{value}%") }
end
