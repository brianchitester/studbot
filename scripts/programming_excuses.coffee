
cheerio = require('cheerio')
deliverables = require './data/deliverables.json'
errors = require './data/errors.json'

module.exports = (robot) ->
  objectRegex = deliverables.join('|')
  errorRegex = errors.join('|')
  regexTemplate = '^.*?\\b(objectRegex)\\b.*?\\b(errorRegex)\\b.*?$'
  regexTemplate = regexTemplate.replace 'objectRegex', objectRegex
  regexTemplate = regexTemplate.replace 'errorRegex', errorRegex
  regex = new RegExp regexTemplate, 'gi'

  robot.hear regex, (resp) ->
      robot.http("http://programmingexcuses.com/")
      .get() (err, res, body) ->
      # pretend there's error checking code here
        if res.statusCode isnt 200
          resp.send "Request came back" + res.statusCode
          return
        $ = cheerio.load(body);
        resp.send $('a').text()