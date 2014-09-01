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
#  setting the variables for your environment
#
# Commands:
#   hubot lunch me
#   hubot lunch me <category?>
#
# Author:
#   Brian Cain (briancain)

latitude=process.env.LATITUDE
longitude=process.env.LONGITUDE
location=process.env.LOCATION
radius=process.env.RADIUS

consumer_key=process.env.CONSUMER_KEY
consumer_secret=process.env.CONSUMER_SECRET
token=process.env.TOKEN
token_secret=process.env.TOKEN_SECRET

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
      msg.send "May I suggest #{nomnoms.name}? It has a rating of #{nomnoms.rating}/5. URL: #{nomnoms.url}"

module.exports = (robot) ->
  robot.respond /lunch me( .*)?/i, (msg) ->
    category = msg.match[1]
    getLunch msg, category
