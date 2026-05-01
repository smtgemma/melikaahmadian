require 'xcodeproj'
project_path = 'ios/Runner.xcodeproj'
project = Xcodeproj::Project.open(project_path)

# Find the Runner target
target = project.targets.find { |t| t.name == 'Runner' }

# Find the Runner group
group = project.main_group.find_subpath('Runner', false)

# Find the existing file reference
file_ref = group.files.find { |f| f.name == 'GoogleService-Info.plist' || f.path.include?('GoogleService-Info.plist') }

if file_ref
  # Fix the path
  file_ref.path = 'GoogleService-Info.plist'
  puts "Updated GoogleService-Info.plist path to be relative to its group."
else
  # Add it correctly if missing
  file_path = 'GoogleService-Info.plist'
  file_ref = group.new_file(file_path)
  target.add_resources([file_ref])
  puts "Added GoogleService-Info.plist correctly."
end

project.save
