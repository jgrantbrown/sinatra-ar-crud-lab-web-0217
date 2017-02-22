require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    @post=Post.create(:name => params[:name], :content => params[:content])
    #redirect to '/posts'
    erb :index
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    @post =Post.find(params[:id])
    erb :show
  end

  get '/posts/:id/edit' do  #load edit form
      @post = Post.find(params[:id])
      erb :edit
    end

  patch '/posts/:id' do #edit action
    @post = Post.find_by_id(params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    erb :show
  end

  delete '/posts/:id/delete' do #delete action
  @post = Post.find_by_id(params[:id])
  @post.delete
  erb :deleted
end

# def erb(filename)
#   template = File.read(filename)
#   erb.result(binding)
# end

end
