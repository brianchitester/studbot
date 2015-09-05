module.exports = (robot) ->
	robot.hear /(yo studbot)/i, (msg) ->
		msg.send "yo"
	robot.hear /(sup studbot)/i, (msg) ->
		msg.send "sup"
