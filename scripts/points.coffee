module.exports = (robot) ->
	scoreboard = robot.brain.get('scoreBoard')
	if(!scoreboard)
		scoreboard =
			chris: 0
			ravi: 0
			brian: 0
			tommy: 0
			christina: 0
			nick: 0
			greyson: 0

	robot.respond /give (.*) (-?\d*) point(s*)/i, (msg) ->

		contestant = msg.match[1]
		points = parseInt( msg.match[2], 10 )
		if (scoreboard[contestant])
			scoreboard[contestant] = scoreboard[contestant] + points
		else
			scoreboard[contestant] = points

		robot.brain.set 'scoreBoard', scoreboard
		msg.send "Ok, " + contestant + " now has "+ scoreboard[contestant] + " points."

	robot.hear /scoreboard/i, (msg) ->
        msg.send '\n\nCURRENT STANDINGS'
        msg.send '-----------------'
        for k,v of scoreboard
            msg.send k + ': ' + v
