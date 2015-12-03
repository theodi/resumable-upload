require 'fog_storage'

class StoredChunk

  def self.save(resumableFilename, file, resumableChunkNumber)
    fog.create_file(resumableFilename, file, resumableChunkNumber)
  end

  def self.destroy(filename, chunk_number)
    fog.delete_file(filename, chunk_number)
  end

  def self.exists?(resumableFilename, resumableChunkNumber)
    fog.file_exists?(resumableFilename, resumableChunkNumber)
  end

  def self.find(filename, chunk_number)
    fog.find_file(filename, chunk_number)
  end

  def self.fog
    @@fog ||= FogStorage.new
    @@fog
  end

end
