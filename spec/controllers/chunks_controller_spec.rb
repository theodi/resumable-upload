require 'spec_helper'
require 'rails_helper'

describe ResumableUpload::ChunksController, type: :controller do
  routes { ResumableUpload::Engine.routes }

  describe "GET 'show'" do

    it "returns 404 if chunk does not exist" do
      get 'show', resumableFilename: "error", resumableChunkNumber: "error", :controller=>"resumable_upload/chunks"
      response.code.should == "404"
    end

    it "returns 200 if chunk exists" do
      stored_chunk = Mongoid::GridFs.put(Tempfile.new("return_200"))
      stored_chunk.metadata = { resumableFilename: "spec_chunk", resumableChunkNumber: "0"}
      stored_chunk.save
      get 'show', resumableFilename: "spec_chunk", resumableChunkNumber: "0"
      response.code.should == "200"
    end

  end

  describe "POST 'create'" do

    it "concatenate a single chunk onto the chunk stack" do
      mock_file = mock_uploaded_file("chunks/spec_chunk.part1", nil)
      post 'create', resumableFilename: "spec_chunk",
        resumableChunkNumber: "1", resumableChunkSize: "5", resumableCurrentChunkSize: "5", resumableTotalSize: "100",
        file: mock_file
      response.code.should == "200"
    end

    it "complete file" do
      mock_file = mock_uploaded_file("chunks/spec_chunk.part1", nil)
      resumable_file_name = "spec_chunk"
      post 'create', resumableFilename: resumable_file_name,
        resumableChunkNumber: "1", resumableChunkSize: "5", resumableCurrentChunkSize: "5", resumableTotalSize: "1",
        file: mock_file
      response.code.should == "200"
    end

  end

end
