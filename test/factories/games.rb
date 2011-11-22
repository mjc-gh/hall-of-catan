FactoryGirl.define do
  factory :game do
    notes "Game Notes"
    
    location { association(:location) }
    players { [association(:player), association(:player)] }
    winner { players.first }
  end
end