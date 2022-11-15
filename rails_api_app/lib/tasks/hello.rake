desc "Print reminder about eating more fruit."

namespace :hello do
  # run it with
  # rake hello:apple
  # rails hello:apple (rails will delegate to rake to do the work)
  task :apple do
    puts "Eat more apples!"
  end
end
