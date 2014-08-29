# Hubot What's For Lunch? Script

Are you tired of figuring out where you should go for lunch? Are decisions just too difficult come noon? Let Hubot give you some suggestions for where you should go!

## Requirements

### Yelp API

You need to have access to Yelps API to use this script. Look at their website for more information on how to get the required keys: http://www.yelp.com/developers/manage_api_keys

### node-yelp

This script hooks into the node-yelp NodeJS package. It's a wrapper for the Yelp V2 API, which makes using the API __very__ easy :)

Should be able to install by doing: `npm install yelp`

https://github.com/olalonde/node-yelp

## Commands

- hubot lunch me
- hobot lunch me category

## Examples

- hubot lunch me
  + `May I suggest Little Big Burger? It has a rating of 4. URL: http://www.yelp.com/biz/little-big-burger-portland-3`
- hubot lunch me mexican
  + `May I suggest Los Gorditos? It has a rating of 3.5. URL: http://www.yelp.com/biz/los-gorditos-portland-3`
