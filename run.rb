require "listen"
require "stringio"

# Function to execute the file and benchmark its runtime
def execute_with_benchmark(file_path)
  benchmark_file = "#{file_path}.benchmark"
  script_dir = File.dirname(file_path)

  start_time = Time.now
  result = Dir.chdir(script_dir) do
    capture_output = StringIO.new
    original_stdout = $stdout
    $stdout = capture_output
    begin
      load file_path
    ensure
      $stdout = original_stdout
    end
    capture_output.string
  end
  end_time = Time.now

  runtime = end_time - start_time

  # Save benchmark time to a file
  File.open(benchmark_file, "w") do |f|
    f.puts "Execution Time: #{runtime.round(4)} seconds"
  end

  puts "File executed successfully."
  puts "Execution Time: #{runtime.round(4)} seconds"
  puts "Output: #{result}"
end

# Main program to watch a file
def watch_file(file_path)
  # Convert file_path to absolute path for comparison
  absolute_file_path = File.expand_path(file_path)
  puts "Watching #{absolute_file_path} for changes..."

  listener = Listen.to(File.dirname(absolute_file_path)) do |modified, added, removed|
    if modified.include?(absolute_file_path) || added.include?(absolute_file_path)
      puts "\nChange detected in #{absolute_file_path}. Executing..."
      execute_with_benchmark(absolute_file_path)
    end
  end

  listener.start
  sleep
end

# Validate and start the watcher
if ARGV.length != 1
  puts "Usage: ruby run.rb <path_to_file>"
  exit
end

target_file = ARGV[0]

unless File.exist?(target_file)
  puts "Error: File #{target_file} does not exist."
  exit
end

watch_file(target_file)
