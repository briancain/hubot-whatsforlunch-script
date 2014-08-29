# Description:
#   A script to suggest where you should go to lunch.
#
# Depends on:
#
#  node-yelp: https://github.com/olalonde/node-yelp
#     - `npm install yelp`
#
#  yelp v2 api: http://www.yelp.com/developers/manage_api_keys
#     - requires keys to query yelp
#
# Commands:
#   hubot lunch me
#   hubot lunch me <category?>
#
# Author:
#   Brian Cain (briancain)

latitude=0
longitude=0
location=""
radius=805 # 805 meters or 0.5 miles

consumer_key=""
consumer_secret=""
token=""
token_secret=""

yelp = require("yelp").createClient({
  consumer_key: consumer_key,
  consumer_secret: consumer_secret,
  token: token,
  token_secret: token_secret
})

getLunch = (msg, category) ->
  if !category || category == " "
    category = "food"
  else
    category = category.replace /^\s+/g, ""

  yelp.search category_filter: "restaurants", term: category, radius_filter: radius, sort: 0, limit: 20, location: location, latitude: latitude, longitude: longitude, (error,data) ->
    if error
      return msg.send "There was a problem processing your request query #{category}, #{error.data}"
    else if data.total == 0
      return msg.send "Your category #{category} returned no results. Try again?"
    else
      nomnoms = data.businesses[Math.floor(Math.random() * data.businesses.length)]
      msg.send "May I suggest #{nomnoms.name}? It has a rating of #{nomnoms.rating}. URL: #{nomnoms.url}"


module.exports = (robot) ->
  robot.respond /lunch me( .*)?/i, (msg) ->
    category = msg.match[1]
    getLunch msg, category
