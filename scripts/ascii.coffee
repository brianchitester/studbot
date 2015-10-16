cheerio = require('cheerio')
querystring = require('querystring')

module.exports = (robot) ->
  robot.respond /gizoogle (.*)/ , (msg) ->
  	robot.http("http://ascii-text.com/online-ascii-banner-text-generator/fire_font-s/" + msg.match[1])
    	.header('Content-Type','application/x-www-form-urlencoded')
    	.post() (err, res, body) ->
    		if res.statusCode isnt 200
    			msg.send "Request problem:" + res.statusCode
    		$ = cheerio.load(body.toString('utf8'))
    		msg.send $('pre').val())

