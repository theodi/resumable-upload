Rails.application.routes.draw do

  mount ResumableUpload::Engine => "/resumable_upload"

  resource :chunk, :only => [:create, :show]

end
