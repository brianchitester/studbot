G = require('gizoogle')

module.exports = (robot) ->
  robot.respond /gizoogle (.*)/ , (msg) ->
    msg.send G.string(msg.match[1])
