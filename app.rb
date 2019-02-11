# app.rb
require 'net/http'
require 'sinatra'
require 'uri'

get '/' do
  redirect '/index'
end

get '/index' do
  # Create query
  uri = URI.parse('https://www.googleapis.com/books/v1/volumes')
  @curr_idx = params['startIndex'].to_i
  @query = params['q']
  q_params = { q: @query, startIndex: @curr_idx }
  uri.query = URI.encode_www_form( q_params )

  # Handle response
  begin
    response = Net::HTTP.get(uri)
    response = JSON.parse(response)

    # Currently GoogleBooks doesn't reliably provide pagination
    # total_items = response['totalItems']
    # @max_page = total_items/10-1
    # @max_page += 1 if total_items%10 > 0

    p_str = "/index?q=#{@query}&startIndex=#{@curr_idx-1}"
    n_str = "/index?q=#{@query}&startIndex=#{@curr_idx+1}"
    @prev_url = URI::encode(p_str)
    @next_url = URI::encode(n_str)

    @books = response['items']
    @error = false
  rescue StandardError
    @error = true
  end

  erb :index
end
