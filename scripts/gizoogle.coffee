G = require('gizoogle')

module.exports = (robot) ->
  robot.respond /gizoogle (.*)/ , (msg) ->
    console.log msg.match[1]
    msg.send G.string(msg.message.text)
