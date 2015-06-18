#!/usr/bin/env ruby

# redshift: neutal temperature is 6500k, higher than it, will be more blue

require 'httparty'

# http://stackoverflow.com/questions/18581792/ruby-on-rails-and-json-parser-from-url
# http://stackoverflow.com/questions/23030344/how-can-i-get-latitude-and-longitude-from-json-web-service
address = "melbourne victoria"
address_weather = address.gsub(' ', ',')
geo_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + address + "&sensor=true"
response = HTTParty.get(geo_url)
json = JSON.parse(response.body)
my_extra_temp = 5000

lat = json['results'][0]['geometry']['location']['lat'].to_s
lng = json['results'][0]['geometry']['location']['lng'].to_s

p 'Current location: ' + address
p 'API url: ' + geo_url
p 'lat: ' + lat
p 'lng: ' + lng

# Weather
# http://openweathermap.org/current
weather_url = "http://api.openweathermap.org/data/2.5/weather?q=" + address_weather
response_weather = HTTParty.get(weather_url)
json_weather = JSON.parse(response_weather.body)

temp = json_weather['main']['temp'].round
# I need more red color
my_temp = (temp + my_extra_temp).to_s

p 'Weather api: ' + weather_url
p 'Temperature: ' + my_temp + ' kelvin'

#redshift_cmd = "gtk-redshift -l " + lat + ":" + lng + " -t " + my_temp + ":" + my_temp + " -g 0.9 -o -m vidmode:screen=0"

# Better setup?
redshift_cmd = "gtk-redshift -l " + lat + ":" + lng + " -t " + my_temp + ":" + my_temp + " &"

# This is used to test
#redshift_cmd = "gtk-redshift -l -37.9:144.7 -t 5700:5300 -g 1 -o -m vidmode:screen=0"

p "Command is: " + redshift_cmd
system(redshift_cmd)

p 'Done'
