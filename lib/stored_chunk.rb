require 'mongoid/grid_fs'

class StoredChunk

  def self.save(file, resumableFilename, resumableChunkNumber)
    stored_chunk = Mongoid::GridFs.put(file)
    stored_chunk.metadata = { resumableFilename: resumableFilename, resumableChunkNumber: resumableChunkNumber}
    stored_chunk.save
  end

  def self.destroy(file)
    Mongoid::GridFs.delete(file._id.to_s)
  end

  def self.exist(resumableFilename, resumableChunkNumber)
    return (Mongoid::GridFs.find({"metadata.resumableFilename" => resumableFilename,
      "metadata.resumableChunkNumber" => resumableChunkNumber}) != nil)
  end

end
