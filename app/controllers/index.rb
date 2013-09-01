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

get '/game' do
  card = Deck.first.cards.first

  erb :game, layout: false, locals: {card: card}
end

get '/scores_display' do

end

get '/scores' do
  erb :scores
end

get '/logout' do
  session.clear
  erb :index
end
  
# POST ===========================================

post '/register' do
  user = User.create(params[:user])  
  session[:user_id] = user.id
  redirect to("/user/#{current_user.id}")
end

post '/user' do
  user = User.authenticate(params[:user][:email], params[:user][:password])
  if user 
    session[:user_id] = user.id
    redirect to("/user/#{current_user.id}")
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
  user_answer = params[:game][:answer].downcase
  @cci = current_card.id
  @cca = current_card.answer
  @ccq = current_card.question
  @ccd = current_card.deck_id
  @ua = user_answer
  if current_card.answer.downcase == user_answer
    guess = Guess.create(response: user_answer, correctness: true, card_id: current_card.id, round_id: 1)
    @p = "YOU WERE RIGHT"
    correct_guesses = Guess.where(correctness: true).count
    @c = Guess.last 
    @g = Guess.all
    @d = Guess.last.response
    @score = correct_guesses
    erb :game, layout: false
  else
    @p_wrong = "this is working"
  end
end


