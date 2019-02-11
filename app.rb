# app.rb
require 'sinatra'
require 'uri'
require 'net/http'
require 'pry'

get '/' do
  redirect '/index'
end

get '/index' do
  uri = URI.parse('https://www.googleapis.com/books/v1/volumes')
  q_params = { q: params['q'] }
  uri.query = URI.encode_www_form( q_params  )

  # Parse response
  response = Net::HTTP.get(uri)
  response = JSON.parse(response)
  # TODO: error handling on failed http request

  @books = response['items']
  erb :index
end
