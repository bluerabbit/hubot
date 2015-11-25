# Commands:
#   hubot deploy <repo_name> <merge_branch_name>
module.exports = (robot) ->

  github = require("githubot")

  robot.respond /deploy\s+(.*)\s+(.*)/i, (msg)->
    repo       = github.qualified_repo msg.match[1]
    baseBranch = 'deploy'
    headBranch = msg.match[2]

    accountName = msg.envelope.user.name || "anonymous" #このスクリプトを呼び出した人のSlackアカウント名
    channelName = msg.envelope.room      || "anonymous" #このスクリプトを呼び出したSlackのChannel

    body = """
      ・Created By #{accountName} on #{channelName} Channel
    """

    data = { title: "Deploy #{headBranch} from #{baseBranch}", head: headBranch, base: baseBranch, body: body }
    url  = "https://api.github.com/repos/#{repo}/pulls"

    github.handleErrors (response) ->
      msg.send JSON.stringify(data)
      msg.send JSON.stringify(response)
      msg.send "Error StatusCode -> #{response.statusCode}!"

    github.post url, data, (pullreq) ->
      msg.send pullreq.html_url
