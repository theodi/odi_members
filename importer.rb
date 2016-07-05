require 'json'
require_relative 'lib/odi_members'
require 'dotenv'
Dotenv.load

j = JSON.parse File.read 'members.json'

j['memberships'].each do |m|
  o = Organisation.new m
  o.save
end
