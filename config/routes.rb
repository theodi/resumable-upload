ResumableUpload::Engine.routes.draw do

  resource :chunk, :only => [:create, :show]

end
