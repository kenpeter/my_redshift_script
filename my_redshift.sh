#!/usr/bin/env ruby

# redshift: neutal temperature is 6500k, higher than it, will be more blue

require 'httparty'

# http://stackoverflow.com/questions/18581792/ruby-on-rails-and-json-parser-from-url
# http://stackoverflow.com/questions/23030344/how-can-i-get-latitude-and-longitude-from-json-web-service
address = "melbourne victoria"
url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + address + "&sensor=true"
response = HTTParty.get(url)
json = JSON.parse(response.body)

lat = json['results'][0]['geometry']['location']['lat'].to_s
lng = json['results'][0]['geometry']['location']['lng'].to_s

p 'Current location: ' + address
p 'API url: ' + url
p 'lat: ' + lat
p 'lng: ' + lng

redshift_cmd = "gtk-redshift -l " + lat + ":" + lng + " -t 5700:5300 -g 0.9 -o -m vidmode:screen=0"
#redshift_cmd = "gtk-redshift -l -37.9:144.7 -t 5700:5300 -g 1 -o -m vidmode:screen=0"

p "Command is: " + redshift_cmd
system(redshift_cmd)

p 'Done'
