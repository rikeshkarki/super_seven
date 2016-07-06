require 'httparty'
require 'pry'

module Services
  class SuperheroUniverse

    include HTTParty

    base_uri 'http://superheroes.com'

    def get_heroes(power = nil)
      heroes = self.class.get('/api/v1/heroes', power: power)
      heroes.map{ |hero| Hero.new(hero['first_name'], hero['last_name'])}
    end
  end
end
