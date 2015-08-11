class Contest < ActiveRecord::Base
  belongs_to :group
  
  has_many :users
  
  validates :name, presence: true, length: { minimum: 3 }
end
