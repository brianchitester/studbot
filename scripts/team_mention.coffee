Team = require './models/team'
module.exports = (robot) ->
	robot.brain.data.teams or= {}
	Team.robot = robot
	regex = new RegExp '@(.*)Squad', 'gi'
	robot.hear regex, (msg) ->
		teamName = msg.match[0].substring(1)
		teams = Team.all()
		alertString = ""
		for key, teamData of Team.store()
			if(key == teamName)
				for user in teamData
					nameLookUp =  @robot.brain.usersForFuzzyName user
					if(nameLookUp)
						for k of (robot.brain.data.users)
        					if(robot.brain.data.users[k]['name'] == nameLookUp.name)
        						alertString = alertString + " @" + robot.brain.data.users[k]['mention_name']
				if(alertString)
					msg.send alertString

