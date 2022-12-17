# frozen_string_literal: true

class TyphTestService
  def self.get_results
    stuff = []
    resp = Typhoeus::Response.new(code: 200, body: "{'name': 'paul'}")
    Typhoeus.stub('www.example.com').and_return(resp)

    hydra = Typhoeus::Hydra.hydra

    first_req = Typhoeus::Request.new('www.example.com')
    first_req.on_complete do |response|
      stuff << response.body
    end

    second_req = Typhoeus::Request.new('www.example.com')
    second_req.on_complete do |response|
      stuff << response.body
    end

    hydra.queue first_req
    hydra.queue second_req

    hydra.run
    puts 'stuff'
    puts stuff
  end
end
