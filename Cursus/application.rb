require 'sinatra'

get '/' do
  erb :home
end

get '/over' do
  erb :over
end

get '/contact' do
  erb :contact
end

get '/welkom/:naam' do
  @naam = params[:naam]
  erb :welkom

end

get '/posts/:id' do
  @post = Post.get( params[:id] )
end
