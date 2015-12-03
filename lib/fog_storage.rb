require 'fog'
require 'dotenv'
Dotenv.load

class FogStorage

  attr_reader :connection

  def initialize
    @connection = Fog::Storage.new({
      :aws_access_key_id => ENV['AWS_ACCESS_KEY'],
      :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
      :provider => "AWS",
      :region => "eu-west-1"
    })
  end

  def bucket
    @connection.directories.get(ENV['AWS_BUCKET_NAME'])
  end

  def create_file(filename, content)
    bucket.files.create(
      body: content,
      key: filename,
    )
  end

  def find_file(filename)
    bucket.files.find { |i| i.key == filename }
  end

  def delete_file(filename)
    find_file(filename).destroy
  end

  def file_exists?(filename)
    !find_file(filename).nil?
  end

end
