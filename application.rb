require 'bundler'
Bundler.require(:default)

# need install dm-sqlite-adapter
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :body, Text
  property :created_at, DateTime
  property :author, String
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Post.auto_upgrade!

enable :sessions

get '/' do
  @posts = Post.all
  erb :home
end

get '/over' do
  erb :over
end

get '/contact' do
  erb :contact
end

get '/login' do
  erb :login
end

post '/login' do
  if params[:username] == 'boris' && params[:password] == 'password'
    session[:logged_in] = true
  else
    session[:logged_in] = false
  end

  redirect '/'
end

get '/logout' do
  session[:logged_in] = false
  redirect '/'
end

get '/posts/new' do
  requires_login
  erb :nieuwepost
end

get '/posts/:id' do
  @post = Post.get(params[:id])
  erb :post
end

get '/posts/:id/edit' do
  requires_login
  @post = Post.get(params[:id])
  erb :editpost
end

post '/posts/:id' do
  @post = Post.get(params[:id])
  @post.attributes = params[:post]
  @post.save
  redirect '/'
end

get '/posts/:id/delete' do
  requires_login
  @post = Post.get(params[:id])
  erb :deletepost
end

post '/posts/:id/delete' do
  @post = Post.get(params[:id])
  @post.destroy
  redirect '/'
end


post "/posts" do
  @post = Post.new(params[:post])
  @post.save
  redirect "/"
end

get '/style.css' do
  scss :"/scss/style"
end

def requires_login
  redirect '/' unless session[:logged_in]
end