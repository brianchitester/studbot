module.exports = (robot) ->
	scoreboard = robot.brain.get('scoreBoard')
	if(!scoreboard)
		scoreboard = {}

	robot.respond /give (.*) (-?\d*) point(s*)/i, (msg) ->

		contestant = msg.match[1].toLowerCase()
		giver = msg.message.user.name.toLowerCase()
		points = parseInt( msg.match[2], 10 )
		if (scoreboard[contestant])
			scoreboard[contestant] = scoreboard[contestant] + points
			if(scoreboard[giver])
				scoreboard[giver] = scoreboard[giver] - points
			else
				scoreboard[giver] = 0 - points
		else
			scoreboard[contestant] = points
			if(scoreboard[giver])
				scoreboard[giver] = scoreboard[giver] - points
			else
				scoreboard[giver] = 0 - points

		robot.brain.set 'scoreBoard', scoreboard
		msg.send giver + " gave " + contestant + " " + points + " points."

	robot.hear /scoreboard/i, (msg) ->
		console.log msg.message
		message = 'CURRENT STANDINGS'
		message = message + '\n==========================================='
		scoreboardArray = do (scoreboard) ->
			keys = Object.keys(scoreboard).sort (a, b) -> scoreboard[b] - scoreboard[a]
			{name, count: scoreboard[name]} for name in keys
		for i in scoreboardArray
            message = message + '\n' + i.name + ': ' + i.count
        msg.send message
