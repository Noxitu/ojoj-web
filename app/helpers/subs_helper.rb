module SubsHelper

  def result_title(numeric)
    case numeric
	  when 0 then 'Accepted'
	  when 1 then 'Wrong answer' 
	  when 2 then 'Time Limit Exceeded' 
	  when 3 then 'Memory Limit Exceeded' 
	  when 4 then 'Runtime Error' 
	  when 5 then 'Compilation Error' 
	  when 6 then 'Unknown Error'
	  when 7 then 'Nonzero Exit Code'
	  when nil then 'Waiting' 
	  when -1 then 'Waiting'
	end
  end
  
  def result_class(numeric)
    case numeric
	  when 0 then 'success'
	  when 1 then 'danger' 
	  when 2 then 'primary' 
	  when 3 then 'warning' 
	  when 4 then 'warning' 
	  when 5 then 'danger'
	  when 6 then 'danger'
	  when 7 then 'info'
	  when nil then 'default'
      when -1 then 'default'
	end
  end
  
  def dynamic_precision(value, unit=nil, digits=3, max_prec=2)
	if value
	  prec = [digits - value.to_i.to_s.length, max_prec].min
	  if prec > 0
	    "%.#{prec}f #{unit}" % value
	  else
	    "#{value.to_i} #{unit}"
	  end
	end
  end
end
