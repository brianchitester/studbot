# Description:
#   responds to things
#
# Dependencies:
#
#
# Configuration:
#
#
# Commands:
#  sup studbot - responds with sup
#  yo studbot- responds with yo
#
# Author:
#
#
# Contributors:
#   tparnell


module.exports = (robot) ->
	robot.hear /(yo studbot)/i, (msg) ->
		msg.send "yo"
	robot.hear /(sup studbot)/i, (msg) ->
		msg.send "sup"
