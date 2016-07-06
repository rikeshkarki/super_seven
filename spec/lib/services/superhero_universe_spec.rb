require 'services/superhero_universe'
require './spec/lib/services/pact_helper.rb'
require 'hero'
require 'pry'

describe Services::SuperheroUniverse, :pact => true do

  before do
    # Configure your client to point to the stub service on localhost using the port you have specified
    Services::SuperheroUniverse.base_uri 'localhost:1234'
  end

  subject { Services::SuperheroUniverse.new }

  describe "get" do

    before do
      superhero_services.given("a superhero exists").
        upon_receiving("a request for a superhero").
        with(method: :get, path: '/api/v1/heroes', query: '').
        will_respond_with(
          status: 200,
          headers: {'Content-Type' => 'application/json; charset=utf-8'},
          body: [
              {
              first_name: 'Dr',
              last_name: 'Fate',
              fka: 'Believer',
              powers: ['Light', 'Flight'],
              universe: 'DC'
            },
            {
              first_name: 'Mad',
              last_name: 'Max',
              fka: 'Mad Machine',
              powers: ['Super Strength', 'Agility'],
              universe: 'CC'
            }
          ]
        )
    end

    it "returns a superhero" do
      expect(subject.get_heroes.first.first_name).to eq('Dr')
      expect(subject.get_heroes.last.last_name).to eq('Max')
    end

  end

end