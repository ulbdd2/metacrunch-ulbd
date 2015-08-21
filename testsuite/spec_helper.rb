require_relative "../spec/spec_helper"

def perform_step(step_class, mab_xml)
  transform(step_class, Metacrunch::Mab2::Document.from_aleph_mab_xml(mab_xml), Metacrunch::SNR.new)
end

def read_mab_file(path_to_file)
  mab_files_dir = File.expand_path(File.join(File.dirname(__FILE__), "mab_files"))
  File.read(File.expand_path(File.join(mab_files_dir, path_to_file)))
end
