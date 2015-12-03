require 'spec_helper'

describe StoredChunk do

  it 'saves a file' do
    resumableFilename = 'my-awesome-file'
    file = 'foobar'
    resumableChunkNumber = 1

    expect_any_instance_of(FogStorage).to receive(:create_file).with(resumableFilename, file, resumableChunkNumber)

    described_class.save(resumableFilename, file, resumableChunkNumber)
  end

  it 'deletes a file' do
    filename = 'my-terrible-file'
    chunk_number = 1

    expect_any_instance_of(FogStorage).to receive(:delete_file).with(filename, chunk_number)

    described_class.destroy(filename, chunk_number)
  end

  it 'checks if a chunk exists' do
    filename = 'my-terrible-file'
    chunk_number = 1

    expect_any_instance_of(FogStorage).to receive(:file_exists?).with(filename, chunk_number)

    described_class.exists?(filename, chunk_number)
  end

  it 'finds a file' do
    filename = 'my-terrible-file'
    chunk_number = 1

    expect_any_instance_of(FogStorage).to receive(:find_file).with(filename, chunk_number)

    described_class.find(filename, chunk_number)
  end

end
