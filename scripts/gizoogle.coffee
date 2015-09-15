cheerio = require('cheerio')
querystring = require('querystring')
BadWords = require('bad-words')

module.exports = (robot) ->
  robot.respond /gizoogle (.*)/ , (msg) ->
  	filter = new BadWords()
  	robot.http("http://gizoogle.net/textilizer.php")
    	.header('Content-Type','application/x-www-form-urlencoded')
    	.post(querystring.stringify(translatetext: msg.match[1])) (err, res, body) ->
    		if res.statusCode isnt 200
    			msg.send "Request problem:" + res.statusCode
    		$ = cheerio.load(body.toString('utf8'))
    		msg.send filter.clean($('textarea[name="translatetext"]').val())
    		
