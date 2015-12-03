require_dependency "resumable_upload/application_controller"
require 'stored_chunk'

module ResumableUpload
  class ChunksController < ActionController::Base

    layout nil

        #GET /chunk
        def show

          if StoredChunk.exists?(params[:resumableFilename], params[:resumableChunkNumber])
            #Let resumable.js know this chunk already exists
            render :nothing => true, :status => 200
          else
            #Let resumable.js know this chunk doesnt exists and needs to be uploaded
            render :nothing => true, :status => 404
          end

        end

        #POST /chunk
        def create
          StoredChunk.save(params[:resumableFilename], params[:file].tempfile.read, params[:resumableChunkNumber])
          #Concatenate all the partial files into the original file
          currentSize = params[:resumableChunkNumber].to_i * params[:resumableChunkSize].to_i
          filesize = params[:resumableTotalSize].to_i

          if params[:resumableTotalChunks].to_i == StoredChunk.total(params[:resumableFilename])

            #Create a target file
            target_file = Tempfile.new(params[:resumableFilename])
            target_file.binmode
            for i in 1..params[:resumableChunkNumber].to_i
              #Select the chunk
              chunk = StoredChunk.find(params[:resumableFilename], i)

              chunk.body.each_line do |line|
                target_file.write(line)
              end

              #Deleting chunk
              StoredChunk.destroy(chunk.key)
            end

            target_file.rewind

            stored_csv = FogStorage.new.create_file(params[:resumableFilename], target_file.read)

            render json: { id: stored_csv.key }, :status => 200
          else
            render :nothing => true, :status => 200
          end
        end

  end
end
