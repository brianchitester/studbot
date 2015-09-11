module.exports = (robot) ->

	robot.respond /unit_test status/i, (msg) ->
		robot.http("http://vbujenkins.vistaprint.net/job/Studio.JavaScript.UnitTests/lastBuild/api/json")
  			.get() (err, res, body) ->
  				data = JSON.parse(body)
  				message = "\nLATEST UNIT TEST STATUS:\n" + data.fullDisplayName + ': ' + data.result + ''
  				if(data.result == 'FAILURE')
  					message = message + "\n Possible Culprit: @" + data.culprits[0].fullName
  				msg.send message
  

