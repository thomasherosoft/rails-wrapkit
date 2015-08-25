namespace :main  do
  desc "run db:reset, flush redis and restart pow"
  task :reset do
    FileUtils.mkdir_p(File.join(Rails.root, 'tmp'))
    restart_file = File.join(Rails.root, 'tmp', 'restart.txt')
    Kernel.system "touch #{restart_file}"
    Kernel.system "rake --trace db:drop"
    Kernel.system "rake --trace db:reset"
    Kernel.system "redis-cli 'flushdb'"
    Kernel.system "redis-cli -n 2 'flushdb'"
    Kernel.system "echo 'flush_all' | nc localhost 11211"
    Kernel.system "curl -XDELETE 'http://127.0.0.1:9200/_all/'"
  end
end
