FactoryGirl.define do
  factory :game do
    notes "Game Notes"
    played_on Time.now
    
    location { association(:location) }
    players { [association(:player), association(:player)] }
    winner { players.first }
  end
end