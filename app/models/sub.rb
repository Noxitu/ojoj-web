class Sub < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  
  validates :src, presence: true, length: { maximum: 102400 }
end
