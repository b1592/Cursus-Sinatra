require 'sinatra'

get "/:name" do
  # params = {:id => 1}
  @name = params[:name]
  erb :home
  # "#{params[:name]}"
end

get '/' do
  erb :home
end

get 'posts/new' do
  erb :nieuwepost

end
