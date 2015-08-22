module.exports = (robot) ->
	robot.hear /(yo), (msg) ->
	msg.send "yo"