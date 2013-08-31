# GET ============================================

get '/' do
  erb :index
end

get '/register' do
  erb :register
end

get '/user' do
  @user = session[:user]
  @email = @user.email
  @id = @user.id
  
  erb :user
end

get '/game' do
  card = Deck.first.cards.first

  erb :game, layout: false, locals: {card: card}
end

get '/scores_display' do

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
    session[:user] = user
    @user = user
    @email = user.email
    @id = user.id
    erb :game 
    # redirect to('/game')
  else
    # an error occurred, re-render the sign-in form, displaying an error
    @error = "Invalid email or password."
    erb :index
  end
end

post '/game' do

end


post '/responses_answers' do
  current_card = Card.find((params[:game][:id]).to_i)

  if current_card.answer.downcase == params[:game][:answer].downcase
    
    correctness = true

    # @user = Round.where(user_id: user.id)
    # @score = @user.first.score
    correct_guesses = guesses.where(correctness: true).count
    total_guesses = self.guesses.count
    self.score = ((correct_guesses.to_f / total_guesses) * 100).to_i
    self.save 
  
    p "this is working" 

    erb :game
  end
 
end


