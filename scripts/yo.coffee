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
#  sup - responds with sup
#  yo - responds with yo
#
# Author:
#
#
# Contributors:
#   tparnell

module.exports = (robot) ->
	robot.respond /yo/i, (msg) ->
		msg.send "yo"
	robot.respond /sup/i, (msg) ->
		msg.send "sup"
