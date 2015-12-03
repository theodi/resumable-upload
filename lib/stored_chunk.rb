require 'fog_storage'

class StoredChunk

  def self.save(file, resumableFilename, resumableChunkNumber)
    fog.create_file(resumableFilename, file, resumableChunkNumber)
  end

  def self.destroy(file)
    fog.delete_file(filename)
  end

  def self.exist(resumableFilename, resumableChunkNumber)
    !fog.find_file(resumableFilename, resumableFilename).nil?
  end

  def self.fog
    @@fog ||= FogStorage.new
    @@fog
  end

end
