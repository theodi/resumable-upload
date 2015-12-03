require 'fog_storage'

class StoredChunk

  def self.save(filename, file, chunk_number)
    fog.create_file full_path(filename, chunk_number), file
  end

  def self.destroy(filename, chunk_number)
    fog.delete_file full_path(filename, chunk_number)
  end

  def self.exists?(filename, chunk_number)
    fog.file_exists? full_path(filename, chunk_number)
  end

  def self.find(filename, chunk_number)
    fog.find_file full_path(filename, chunk_number)
  end

  def self.full_path(filename, chunk_number)
    File.join filename, chunk_number.to_s
  end

  def self.fog
    @@fog ||= FogStorage.new
    @@fog
  end

end
