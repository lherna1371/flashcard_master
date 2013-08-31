require 'csv'

#CREATE DECK

def create_deck(file_path)
	name = File.basename(file_path, ".csv")
	name = name.split('_').map(&:capitalize).join(' ')
	Deck.create(name: name)
end 


def create_cards(file_path, deck)
	CSV.read(file_path, headers: true).each do |row|
		Card.create(row.to_hash.merge(deck_id: deck.id))
	end
end

Deck.delete_all
Card.delete_all

Dir["db/decks/*"].each do |file_path|
	deck = create_deck(file_path)
	create_cards(file_path, deck)
end 
