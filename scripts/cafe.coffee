
cheerio = require('cheerio');
FormData = require('form-data');
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
	        resp.send url

   robot.respond /cafe (entree|veggie|action|grill|deli|salad|soup)/i, (resp) ->
   		itemCategory = resp.match[1]
   		categoryCoefficient = switch
   			when itemCategory == 'entree' then 0
   			when itemCategory == 'veggie' then 1
   			when itemCategory == 'action' then 2
   			when itemCategory == 'grill' then 3
   			when itemCategory == 'deli' then 4
   			when itemCategory == 'salad' then 5
   			when itemCategory == 'soup' then 6	
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
		        			relo = res.headers.location
		        			robot.http(relo)
		        				.get() (err, res, body) ->		        					
		        					$ = cheerio.load(body)
		        					authenticityToken = $('input[name=authenticityToken]')[0].attribs.value
		        					d = new Date()
	        						day = d.getDay()
		        					data = new FormData()
		        					data.append('authenticityToken', authenticityToken)
		        					data.append('x1', 0 + (150 * day))
		        					data.append('x2', 150 + (150 * day))
		        					data.append('y1', 42 + (140 * categoryCoefficient))
		        					data.append('y2', 172 + (140 * categoryCoefficient))
		        					data.submit(relo, (err, res) ->
		        						relo = res.headers.location
		        						console.log relo
		        						robot.http(relo)
		        							.get() (err, res, body) ->
		        								$ = cheerio.load(body)
		        								resp.send $('img[src*="275"]')[0].attribs.src
		        					)