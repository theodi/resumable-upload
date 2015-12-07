require_dependency "resumable_upload/application_controller"
require 'stored_chunk'

module ResumableUpload
  class ChunksController < ActionController::Base

    layout nil

        #GET /chunk
        def show

          if StoredChunk.exists?(params[:resumableIdentifier], params[:resumableChunkNumber])
            #Let resumable.js know this chunk already exists
            render :nothing => true, :status => 200
          else
            #Let resumable.js know this chunk doesnt exists and needs to be uploaded
            render :nothing => true, :status => 404
          end

        end

        #POST /chunk
        def create
          StoredChunk.save(params[:resumableIdentifier], params[:file].tempfile.read, params[:resumableChunkNumber])
          #Concatenate all the partial files into the original file
          currentSize = params[:resumableChunkNumber].to_i * params[:resumableChunkSize].to_i
          filesize = params[:resumableTotalSize].to_i

          if params[:resumableTotalChunks].to_i == StoredChunk.total(params[:resumableIdentifier])

            StoredChunk.join(params[:resumableIdentifier], params[:resumableTotalChunks])
            render :nothing => true, :status => 200
          else
            render :nothing => true, :status => 200
          end
        end

  end
end
