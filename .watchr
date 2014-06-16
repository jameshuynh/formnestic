def run_spec(file)
  unless File.exist?(file)
    puts "#{file} does not exist"
    return
  end

  puts "Running #{file}"
  system "rspec #{file} --backtrace"
  puts
end

watch("spec/.*/*_spec\.rb") do |match|
  run_spec match[0]
end

watch("app/(.*/.*)\.rb") do |match|
  # run_spec %{spec/#{match[1]}_spec.rb} 
  run_spec "spec/helpers/nested_model_helper_spec.rb"
end

watch("lib/(.*/.*)\.rb") do |match|
  # run_spec %{spec/#{match[1]}_spec.rb}
  run_spec "spec/helpers/nested_model_helper_spec.rb"
end
