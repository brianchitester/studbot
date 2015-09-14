G = require('gizoogle')

module.exports = (robot) ->
  robot.respond /gizoogle (.*)/ , (msg) ->
    G.string(msg.match[1], (error, string) ->
    	if(!error)
    		msg.send string
    	else
    		msg.send error)
