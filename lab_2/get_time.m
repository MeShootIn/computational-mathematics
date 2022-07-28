function [time] = get_time()
  a = datevec(now);
  time = a(6);
end
