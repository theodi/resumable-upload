require 'spec_helper'

describe FogStorage do

  subject { described_class.new }

  it 'gets a bucket' do
    expect(subject.bucket.key).to eq(ENV['AWS_BUCKET_NAME'])
  end

  it 'creates a file' do
    subject.create_file("my-awesome-file", "derp")

    expect(subject.bucket.files.count).to eq(1)
    expect(subject.bucket.files.first.key).to eq("my-awesome-file")
    expect(subject.bucket.files.first.body).to eq("derp")
  end

  it 'finds a file' do
    file = subject.create_file("my-awesome-file", "derp")

    expect(subject.find_file('my-awesome-file')).to eq(file)
  end

  it 'deletes a file' do
    subject.create_file("my-awesome-file", "derp")

    expect(subject.bucket.files.count).to eq(1)

    subject.delete_file('my-awesome-file')

    expect(subject.bucket.files.count).to eq(0)
  end

  it 'checks if a file exists' do
    expect(subject.file_exists?('my-awesome-file')).to be false

    subject.create_file("my-awesome-file", "derp")

    expect(subject.file_exists?('my-awesome-file')).to be true
  end

end
