# app.rb
require 'net/http'
require 'sinatra'
require 'uri'

require 'dotenv'
Dotenv.load

get '/' do
  redirect '/index'
end

get '/index' do
  # Create query
  uri = URI.parse('https://www.googleapis.com/books/v1/volumes')
  @query = params['q']
  @curr_idx = params['startIndex'].to_i
  q_params = { q: @query, startIndex: @curr_idx, key: ENV['API_KEY'] }
  uri.query = URI.encode_www_form( q_params )

  @max_page = 0
  @prev_url = '#'
  @next_url = '#'
  @books = []
  unless @query.nil?
    # Handle response
    begin
      puts uri
      response = Net::HTTP.get(uri)
      response = JSON.parse(response)

      # GoogleBooks doesn't reliably provide pages only volume ID's 
      total_items = response['totalItems']
      @max_page = total_items/10-1
      @max_page += 1 if total_items%10 > 0

      p_str = "/index?q=#{@query}&startIndex=#{@curr_idx-1}"
      n_str = "/index?q=#{@query}&startIndex=#{@curr_idx+1}"

      @prev_url = URI::encode(p_str)
      @next_url = URI::encode(n_str)
      @books = response['items']
    rescue StandardError
      @error = true
    end
  end

  erb :index
end
