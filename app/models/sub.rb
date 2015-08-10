def result_name(numeric)
  case numeric
    when 0 then 'AC'
    when 1 then 'WA' 
    when 2 then 'TLE' 
    when 3 then 'MLE' 
    when 4 then 'RE' 
    when 5 then 'CE' 
    when 6 then 'Unknown'
    when 7 then 'NZEC'
    when nil then '-' 
    when -1 then '-'
  end
end

class Sub < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  
  validates :src, presence: true, length: { maximum: 102400 }
  
  def self.as_csv
    CSV.generate do |csv|
      csv << ['subid', 'time', 'status_code', 'taskid', 'userid', 'cpu', 'mem', 'task_name', 'username', 'status', 'src']
      all.each do |sub|
        csv << [sub.id, sub.created_at, sub.result, sub.task.id, sub.user.id, sub.cpu_used, sub.mem_used, sub.task.title, sub.user.name, result_name(sub.result), sub.src ]
      end
    end
  end
end
