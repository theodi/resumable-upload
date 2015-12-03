require 'spec_helper'

ENV['AWS_ACCESS_KEY'] = 'fakeaccesskey'
ENV['AWS_SECRET_ACCESS_KEY'] = 'fakesecret'
ENV['AWS_BUCKET_NAME'] = 'buckethead'

Fog.mock!
require './lib/fog_storage'

describe FogStorage do

  subject { described_class.new }

  before(:all) do
    FogStorage.new.connection.directories.create(key: ENV['AWS_BUCKET_NAME'])
  end

  it 'gets a bucket' do
    expect(subject.bucket.key).to eq(ENV['AWS_BUCKET_NAME'])
  end

  it 'creates a file' do
    subject.create_file("my-awesome-file", "derp", 1)

    expect(subject.bucket.files.count).to eq(1)
    expect(subject.bucket.files.first.key).to eq("my-awesome-file/1")
    expect(subject.bucket.files.first.body).to eq("derp")
  end

  it 'finds a file' do
    file = subject.create_file("my-awesome-file", "derp", 1)

    expect(subject.find_file('my-awesome-file', 1)).to eq(file)
  end

  it 'deletes a file' do
    subject.create_file("my-awesome-file", "derp", 1)

    expect(subject.bucket.files.count).to eq(1)

    subject.delete_file('my-awesome-file', 1)

    expect(subject.bucket.files.count).to eq(0)
  end

end
