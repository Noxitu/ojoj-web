class Contest < ActiveRecord::Base
  belongs_to :group
  
  validates :name, presence: true,length: { minimum: 3 }
  has_many :users
end
