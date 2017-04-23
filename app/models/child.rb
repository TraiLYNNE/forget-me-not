class Child < ActiveRecord::Base
  belongs_to :user
  has_many :adult_children
  has_many :adults, through: :adult_children

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
