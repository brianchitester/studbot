cheerio = require('cheerio');
CronJob = require('cron').CronJob;
module.exports = (robot) ->
	tz = "America/Los_Angeles"
	job = new CronJob('* * * * 1-5', (->
  robot.http("https://github.com/loverajoel/jstips/blob/master/README.md")
  	.get() (err, res, body) ->
      if res.statusCode isnt 200
        return

      date = new Date();
      day = ("0" + (date.getDate()-1)).slice(-2);
      month = ("0" + (date.getMonth() + 1)).slice(-2);
      year = date.getFullYear();
      dateString = year + '-' + month + '-' + day;

      if robot.brain.get('jstip ' + dateString) then return;

      $todayTip = $("p:contains(" + dateString + ")");
      if !$todayTip.length then return;
      
      robot.brain.set('jstip ' + dateString, true);
      $ = cheerio.load(body);
      $tipHeader = $('h1:contains(Tips list)').next();
      tip = '\n'+ $tipHeader.text() + '\n';
      $tipPointer = $tipHeader.next();
      while !$tipPointer.is 'h2'
          		tip = tip + $tipPointer.text() + '\n';
          		$tipPointer = $tipPointer.next();
          	robot.messageRoom "226_studio_off_topic@conf.hipchat.com", tip;
), null, true, tz);
 robot.respond /jstip/i, (resp) ->
      robot.http("https://github.com/loverajoel/jstips/blob/master/README.md")
	      .get() (err, res, body) ->
	      # pretend there's error checking code here
	        if res.statusCode isnt 200
	          resp.send "Request came back" + res.statusCode
	          return
	        $ = cheerio.load(body);
	        $tipHeader = $('h1:contains(Tips list)').next();
	        tip = '\n'+ $tipHeader.text() + '\n';
	        $tipPointer = $tipHeader.next();
	        while !$tipPointer.is 'h2'
          		tip = tip + $tipPointer.text() + '\n';
          		$tipPointer = $tipPointer.next();
          	resp.send tip
