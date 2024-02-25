require 'httparty'
require 'json'

module OpenLibrary
  # Client for the OpenLibrary API
  # This class provides methods to search for books, retrieve detailed information about works,
  # fetch cover images, and obtain author information from the OpenLibrary API.
  class Client
    include HTTParty
    base_uri 'https://openlibrary.org'

    # Searches the OpenLibrary for books matching the specified query.
    #
    # @param query [String] The search query string.
    # @param page [Integer] The page number for pagination (default: 1).
    # @return [Hash] Parsed JSON response containing the search results.
    def search(query, page = 1)
      response = self.class.get('/search.json', query: { q: query, page: page })
      JSON.parse(response.body)
    end

    # Retrieves detailed information about a specific work by its OpenLibrary work ID.
    #
    # @param work_id [String] The OpenLibrary work ID.
    # @return [Hash] Parsed JSON response containing detailed information about the work.
    def get_work(work_id)
      response = self.class.get("/works/#{work_id}.json")
      handle_response(response)
    end

    # Fetches cover images for a specific work by its OpenLibrary work ID.
    # Note: This method returns cover image IDs, which can be used to construct URLs to the images.
    #
    # @param work_id [String] The OpenLibrary work ID.
    # @return [Array] An array of cover image IDs associated with the work.
    def get_covers(work_id)
      response = self.class.get("/works/#{work_id}.json")
      handle_response(response)['covers']
    end

    # Retrieves detailed information about an author by their OpenLibrary author ID.
    #
    # @param author_id [String] The OpenLibrary author ID.
    # @return [Hash] Parsed JSON response containing detailed information about the author.
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
