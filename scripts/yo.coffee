module.exports = (robot) ->
	robot.hear /(yo)/i, (msg) ->
	msg.send "yo"