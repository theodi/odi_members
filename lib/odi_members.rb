require 'sinatra/base'
require 'tilt/erubis'
require 'json'
require 'mongoid'

require_relative 'models/person'
require_relative 'odi_members/racks'
require_relative 'odi_members/helpers'

Mongoid.load!(File.expand_path('../mongoid.yml', File.dirname(__FILE__)), ENV['RACK_ENV'])

module OdiMembers
  class App < Sinatra::Base
    helpers do
      include OdiMembers::Helpers
    end

    get '/' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          @content = '<h1>Hello from OdiMembers</h1>'
          @title = 'OdiMembers'
          erb :index, layout: :default
        end

        wants.json do
          {
            app: 'OdiMembers'
          }.to_json
        end
      end
    end

    get '/people/?' do
      {
        people: Person.all.distinct(:name).sort.map do |name|
          {
            name: name,
            url: "#{request.base_url}/people/#{name}.json"
          }
        end
      }.to_json
    end

    get '/people/:name' do
      person = Person.where(:name => params[:name].parameterize).first
      {
        name: person[:name],
        age: person[:age]
      }.to_json
    end

    post '/people/:name' do
      protected!
      
      body = JSON.parse request.body.read
      @person = Person.new({
        'name' => params[:name].parameterize,
        'age' => body['age']
      })

      if @person.save
        return 201
      else
        return 500
      end
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end
