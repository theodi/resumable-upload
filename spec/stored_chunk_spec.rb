require 'spec_helper'

describe StoredChunk do

  it 'saves a file' do
    filename = 'my-awesome-file'
    chunk_number = 1
    body = 'foobar'

    expect_any_instance_of(FogStorage).to receive(:create_file).with("#{filename}_chunks/#{chunk_number}", body)

    described_class.save(filename, body, chunk_number)
  end

  it 'deletes a file' do
    filename = 'my-terrible-file'
    chunk_number = 1

    expect_any_instance_of(FogStorage).to receive(:delete_file).with("#{filename}_chunks/#{chunk_number}")

    described_class.destroy("my-terrible-file_chunks/1")
  end

  it 'checks if a chunk exists' do
    filename = 'my-terrible-file'
    chunk_number = 1

    expect_any_instance_of(FogStorage).to receive(:file_exists?).with("#{filename}_chunks/#{chunk_number}")

    described_class.exists?(filename, chunk_number)
  end

  it 'finds a file' do
    filename = 'my-terrible-file'
    chunk_number = 1

    expect_any_instance_of(FogStorage).to receive(:find_file).with("#{filename}_chunks/#{chunk_number}")

    described_class.find(filename, chunk_number)
  end

end
