# GET ============================================

get '/' do
  erb :index
end

get '/register' do
  erb :register
end

get '/game' do

  card = Deck.first.cards.first

  erb :game, layout: false, locals: {card: card}
end

get '/scores' do
  erb :scores
end
  
# POST ===========================================

post '/register' do
  user = User.create(params[:user])  
  session[:user_id] = user.id
  redirect to('/game')
end

post '/user' do
  user = User.authenticate(params[:user][:email], params[:user][:password])
  if user
    # successfully authenticated; set up session and redirect
    session[:user_id] = user.id
    redirect to('/game')
  else
    # an error occurred, re-render the sign-in form, displaying an error
    @error = "Invalid email or password."
    erb :index
  end
end

post '/game' do

  erb :game
end


post '/responses_answers' do
  
end

