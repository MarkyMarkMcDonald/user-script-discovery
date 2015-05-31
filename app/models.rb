project_root = File.join(File.dirname(File.absolute_path(__FILE__)), '..')
Dir.glob(project_root + '/app/models/*.rb').each{|f| require f}
