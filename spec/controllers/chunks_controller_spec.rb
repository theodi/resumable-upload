require 'spec_helper'
require 'rails_helper'
require 'mongoid/grid_fs'

describe ResumableUpload::ChunksController, type: :controller do
  routes { ResumableUpload::Engine.routes }

  describe "GET 'show'" do

    it "returns 404 if chunk does not exist" do
      get 'show', resumableIdentifier: "error", resumableChunkNumber: "error", :controller=>"resumable_upload/chunks"
      response.code.should == "404"
    end

    it "returns 200 if chunk exists" do
      stored_chunk = Mongoid::GridFs.put(Tempfile.new("return_200"))
      stored_chunk.metadata = { resumableIdentifier: "spec_chunk", resumableChunkNumber: "0"}
      stored_chunk.save
      get 'show', resumableFilename: "spec_chunk", resumableChunkNumber: "0"
      response.code.should == "200"
    end

  end

  describe "POST 'create'" do

    it "concatenate a single chunk onto the chunk stack" do
      mock_file = mock_uploaded_file("chunks/spec_chunk.part1", nil)
      post 'create', resumableIdentifier: "spec_chunk",
        resumableChunkNumber: "1", resumableChunkSize: "5", resumableCurrentChunkSize: "5", resumableTotalSize: "100",
        file: mock_file
      response.code.should == "200"
    end

  end

end
