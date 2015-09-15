cheerio = require('cheerio')
querystring = require('querystring')

module.exports = (robot) ->
  robot.respond /gizoogle (.*)/ , (msg) ->
    robot.http("http://gizoogle.net/textilizer.php")
    	.header('Content-Type','application/x-www-form-urlencoded')
    	.post(querystring.stringify(translatetext: msg.match[1])) (err, res, body) ->
    		if res.statusCode isnt 200
    			msg.send "Request problem:" + res.statusCode
    		$ = cheerio.load(body.toString('utf8'))
    		msg.send $('textarea[name="translatetext"]').val()
    		
