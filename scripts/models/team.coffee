class Team

  @robot = null

  @store: ->
    throw new Error('robot is not set up') unless @robot
    @robot.brain.data.teams or= {}

  @defaultName: ->
    '__default__'

  @all: ->
    teams = []
    for key, teamData of @store()
      continue if key is @defaultName()
      teams.push new Team(teamData.name, teamData.members)
    teams

  @getDefault: (members = [])->
    @create(@defaultName(), members) unless @exists @defaultName()
    @get @defaultName()

  @count: ->
    Object.keys(@store()).length

  @get: (name)->
    return null unless @exists name
    teamData = @store()[name]
    new Team(teamData.name, teamData.members)

  @getOrDefault: (teamName)->
    if teamName then @get(teamName) else @getDefault()

  @exists: (name)->
    name of @store()

  @create: (name, members = [])->
    return false if @exists name
    @store()[name] =
      name: name
      members: members
    new Team(name, members)

  constructor: (name, @members = [])->
    @name = name or Team.defaultName()

  addMember: (member)->
    return false if member in @members
    @members.push member
    true

  removeMember: (member)->
    return false if member not in @members
    index = @members.indexOf(member)
    @members.splice(index, 1)
    true

  membersCount: ->
    @members.length

  clear: ->
    Team.store()[@name].members = []
    @members = []

  destroy: ->
    delete Team.store()[@name]

  isDefault: ->
    @name is Team.defaultName()

  label: ->
    if @isDefault()
      'team'
    else
      "`#{@name}` team"

module.exports = Team