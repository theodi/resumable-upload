require_dependency "resumable_upload/application_controller"
require 'stored_csv'
require 'stored_chunk'

module ResumableUpload
  class ChunksController < ActionController::Base
    layout nil

    #GET /chunk
    def show
      if StoredChunk.exist(params[:resumableIdentifier], params[:resumableChunkNumber])
        #Let resumable.js know this chunk already exists
        render :nothing => true, :status => 200
      else
        #Let resumable.js know this chunk doesnt exists and needs to be uploaded
        render :nothing => true, :status => 404
      end
    end

    #POST /chunk
    def create
      StoredChunk.save(params[:file].tempfile, params[:resumableIdentifier], params[:resumableChunkNumber])
      render :nothing => true, :status => 200
    end
  end
end
