require 'sinatra/base'
require 'tilt/erubis'
require 'json'
require 'mongoid'
require 'dotenv'
Dotenv.load

require_relative 'models/member'
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

    get '/members/?' do
      respond_to do |wants|
        wants.json do
          Member.all.to_json
        end
      end
    end

    get '/members/:id' do
      respond_to do |wants|
        wants.json do
          Member.where(:membershipId => params[:id]).first.to_json
        end
      end
    end

    post '/members/:id' do
      protected!

      body = JSON.parse request.body.read
      @member = Member.new (
        {
          id: params[:id],
          name: body[:name]
        }
      )

      if @member.upsert
        return 201, {
          magic_link: 'i_just_made_this_up'
        }.to_json
      else
        return 500
      end
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end
