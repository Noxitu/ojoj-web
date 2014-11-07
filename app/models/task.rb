class Task < ActiveRecord::Base
  validates :title, presence: true,length: { minimum: 3 }
  validates :content, presence: true
end
