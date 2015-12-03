require 'fog'
require 'dotenv'
Dotenv.load

class FogStorage

  attr_reader :connection

  def initialize
    @connection = Fog::Storage.new({
      :aws_access_key_id => ENV['AWS_ACCESS_KEY'],
      :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
      :provider => "AWS"
    })
  end

  def bucket
    @connection.directories.get(ENV['AWS_BUCKET_NAME'])
  end

  def create_file(filename, content, chunk_number)
    bucket.files.create(
      body: content,
      key: "#{filename}/#{chunk_number}",
    )
  end

  def find_file(filename, chunk_number)
    bucket.files.find { |i| i.key == "#{filename}/#{chunk_number}" }
  end

  def delete_file(filename, chunk_number)
    find_file(filename, chunk_number).destroy
  end

end
