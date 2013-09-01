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

get '/scores_display' do

end

get '/scores/:id' do
 
  round = []
  Round.all.each do |rv|
   round << Round.where(user_id: current_user.id)
  end
  @user = current_user.email
  @round = round
  decks = []
  @round.each do |n|
     decks << Deck.where(id: n.first.deck_id)
  end
  @decks = decks
  erb :scores
end



get '/logout' do
  session.clear
  redirect('/')
end



# get '/game' do
#   decks = []
#   cards = []
#   ids_decks = []
#   params[:id_deck].each do |x,y|
#     if y == "on"
#       decks << Deck.find(x)
#       ids_decks << x
#     end
#   end
#   ids_decks.each do |v|
#     Card.where(deck_id: v).each do |c|
#       cards << c
#     end
#   end
#   @cards = cards
#   erb :game
# end


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


# post '/game' do
#   decks = []
#   cards = []
#   ids_decks = []
#   params[:id_deck].each do |x,y|
#     if y == "on"
#       decks << Deck.find(x)
#       ids_decks << x
#     end
#   end
#   ids_decks.each do |v|
#     Card.where(deck_id: v).each do |c|
#       cards << c
#     end
#   end
#   redirect('/game')
# end

post '/game' do
  cards = []
  # params[:id_deck].each do |x,y|
  #   if y == "on"
  #     Card.where(deck_id: x).each do |c|
  #       cards << c
  #     end  
  #   end
  # end
  @p = params[:options]
  # card_coll = Card.where(deck_id: params[:options])
  Card.all.each do |x|
    if x.deck_id.to_i == params[:options].to_i
      cards << x
    end
  end
  @cards = cards
  p @current_val = @cards.first.id
  # @cards = cards
  # @current_val = @cards.first.id
  erb :game
end


post '/game/:id' do 
  cards = [] 
  current_card = Card.find(params[:id])
  Card.all.each do |x|
    if x.deck_id.to_i == current_card.deck_id.to_i
      cards << x
    end
  end
  @cards = cards
  @score = Guess.where(correctness: true).count
  if current_card.id == Card.where(deck_id: current_card.deck_id).last.id
    round = Round.create(user_id: current_user.id, deck_id: current_card.deck_id, score: @score)
    redirect('/scores')
  end
    user_answer = params[:game][:answer].downcase
  if current_card.answer.downcase == user_answer
    guess = Guess.create(response: user_answer, correctness: true, card_id: current_card.id, round_id: 1)
  else
    @p = "SUPER WRONG"
  end 
  @current_val = current_card.id.to_i + 1
  erb :game
end


