module.exports = (robot) ->
	scoreboard = {
		"chris": 10,
		"brian" -5,
		"ravi": 1
	}
	
	robot.hear /studbot give (.*) (\d*) points/i, (msg) ->
		msg = msg.split(" ")
		contestant = msg[2].toLower();
		points = msg[3]
		if (scoreboard.hasKey(contestant))
			scoreboard[contestant] = scoreboard[contestant] + points
		else
			scoreboard[contestant] = points

		msg.send "Ok, I gave " +contestant+ " "+ points+"points."

	robot.hear /scoreboard/i, (msg) ->
		msg.send scoreboard
