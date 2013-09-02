# GET ============================================

get '/' do
  erb :index
end

get '/register' do
  erb :register
end

get '/user/:id' do
  @decks = Deck.all
  erb :user
end

get '/scores' do
  @rounds = current_user.rounds
  @email = current_user.email
  erb :scores
end


get '/logout' do
  session.clear
  redirect('/')
end


get '/play/:id' do
  @round = Round.find(params[:id])
  @cards = @round.deck.cards
  @current_card = @cards.first
  erb :game
end

# POST ===========================================

post '/register' do
  p params
  @user = User.new(params[:user])  
  if @user.save
    session[:user_id] = user.id
    redirect to("/user/#{current_user.id}")
  else
    @errors =  @user.errors.full_messages
    erb :register
  end
end

post '/user' do
  user = User.authenticate(params[:user][:email], params[:user][:password])
  if user 
    session[:user_id] = user.id
    redirect to("/user/#{current_user.id}")
  else
   
  
    erb :index
  end
end

post '/game' do
  deck = Deck.find(params[:options])
  round = Round.create(user_id: current_user.id, deck_id: deck.id)
  redirect "/play/#{round.id}"
end


post '/play/:id' do
  @round = Round.find(params[:id])
  @current_card = Card.find(params[:card])
  @cards = @current_card.deck.cards
  user_answer = params[:game][:answer].downcase
  correctness = (@current_card.answer.downcase == user_answer)
  guess = Guess.create(response: user_answer, correctness: correctness, card_id: @current_card.id, round_id: @round.id )
  
  if correctness
    card_index= @cards.index(@current_card)
    @current_card = @cards[card_index + 1]
    @round.update_attributes(score: (@round.score + 1))
  else
    @error_message = "Try Again!"
  end 

  if @current_card == nil
    redirect "/scores"
  else
    @score = @round.score 
    erb :game
  end
end


