github = require('githubot')
github.get 'https://api.github.com/user/repos', { type: 'private' }, (repos) ->
  console.log repos[0].name
