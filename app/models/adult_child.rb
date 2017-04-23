class AdultChild < ActiveRecord::Base
  belongs_to :child
  belongs_to :adult
end
