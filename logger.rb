def log(text, filename: "log.txt")
  File.open(filename, "a") do |f|
    f.puts "LOG: #{text}"
  end
end 