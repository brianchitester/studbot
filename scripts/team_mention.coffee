Team = require './models/team'
module.exports = (robot) ->
	robot.brain.data.teams or= {}
	Team.robot = robot
	regex = new RegExp '@(.*)Squad', 'gi'
	robot.hear regex, (msg) ->
		teamName = msg.match[0].substring(1)
		teams = Team.all()
		alertString = ""
		for team in teams
			msg.send team.name
			if(team.name == teamName)
				msg.send "found"
				for user in team.members
					nameLookUp = robot.brain.userForFuzzyName(user)
					if(nameLookUp)
						alertString = alertString + " @" + nameLookUp.mention_name
				msg.send alertString

