require_dependency "resumable_upload/application_controller"
require 'stored_csv'
require 'stored_chunk'

module ResumableUpload
  class ChunksController < ActionController::Base

    layout nil

        #GET /chunk
        def show

          if StoredChunk.exist(params[:resumableFilename], params[:resumableChunkNumber])
            #Let resumable.js know this chunk already exists
            render :nothing => true, :status => 200
          else
            #Let resumable.js know this chunk doesnt exists and needs to be uploaded
            render :nothing => true, :status => 404
          end

        end

        #POST /chunk
        def create
          StoredChunk.save(params[:file].tempfile, params[:resumableFilename], params[:resumableChunkNumber])
          #Concatenate all the partial files into the original file
          currentSize = params[:resumableChunkNumber].to_i * params[:resumableChunkSize].to_i
          filesize = params[:resumableTotalSize].to_i
          #When all chunks are uploaded
          if (currentSize + params[:resumableCurrentChunkSize].to_i) >= filesize

            #Create a target file
            target_file = Tempfile.new(params[:resumableFilename])
            for i in 1..params[:resumableChunkNumber].to_i
              #Select the chunk
              chunk = Mongoid::GridFs.find({"metadata.resumableFilename" => params[:resumableFilename],
                "metadata.resumableChunkNumber" => "#{i}"})
              chunk.data.each_line do |line|
                target_file.write(line)
              end

              #Deleting chunk
              StoredChunk.destroy(chunk)
            end

            target_file.rewind

            stored_csv = StoredCSV.save(target_file, params[:resumableFilename])

            render json: { id: stored_csv.id.to_s }, :status => 200
          else
            render :nothing => true, :status => 200
          end
        end

  end
end
