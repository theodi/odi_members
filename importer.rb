require 'json'
require_relative 'lib/models/organisation'

j = JSON.parse File.read 'members.json'

j['memberships'].each do |m|
  o = Organisation.new m
  o.save
end
