
cheerio = require('cheerio');
module.exports = (robot) ->

   robot.respond /cafe menu/i, (resp) ->
      robot.http("http://www.hobbsbrook.com/amenities/dining/")
      .get() (err, res, body) ->
      # pretend there's error checking code here
        if res.statusCode isnt 200
          resp.send "Request came back" + res.statusCode
          return
        $ = cheerio.load(body);
        url = $(':header:contains(275)').parent().parent().find('.img-menu > img').attr('src')
        robot.http("http://cropmyimage.net/fetch/?url=" + url)
        .get() (err, res, body) ->
        	relo = res.headers['location']
        	robot.http(relo)
        	.get() (err, res, body) ->
        		relo = res.headers['location']
        		robot.http(relo)
        		data =
        			x1: 10
    			 	x2: 450
    			 	y1: 10
    			 	y2: 509
			 	.post(data) (err, res, body) ->
        			resp.send body
   