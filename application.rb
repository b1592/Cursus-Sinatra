require 'sinatra'
require 'sass'
require 'data_mapper'


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

<<<<<<< HEAD
get '/style.css' do 
=======
get '/posts/new' do
  erb :nieuwepost
end

post "/posts" do
  @post = Post.new(params[:post])
  @post.save
  redirect "/"
end

get '/style.css' do
>>>>>>> 2bf013c48a4385052d785b9bbdd03a9b6b28a35e
  scss :"/scss/style"
end
