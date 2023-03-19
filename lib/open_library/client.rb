require 'httparty'
require 'json'

module OpenLibrary
  class Client
    include HTTParty
    base_uri 'https://openlibrary.org'

    def search(query, page = 1)
      response = self.class.get('/search.json', query: { q: query, page: page })
      JSON.parse(response.body)
    end

    def get_work(work_id)
      response = self.class.get("/works/#{work_id}.json")
      handle_response(response)
    end

    def get_covers(work_id)
      response = self.class.get("/works/#{work_id}.json")
      handle_response(response)['covers']
    end

    def get_author(author_id)
      response = self.class.get("/authors/#{author_id}.json")
      handle_response(response)
    end

    private

    def handle_response(response)
      case response.code
      when 200
        JSON.parse(response.body)
      else
        raise OpenLibrary::Error, "API request failed with status code: #{response.code}, message: #{response.message}"
      end
    end
  end
end
