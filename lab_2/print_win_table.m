function print_win_table(algo, sizes, time_wins, nz_wins)
  fprintf('%s\n', algo);
  fprintf('n\ttime_win\tnz_win\n');

  for i = 1:length(sizes)
    fprintf('%d\t%f\t%f\n', sizes(i), time_wins(i), nz_wins(i));
  end
end
