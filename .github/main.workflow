workflow "Deploy to Heroku" {
  resolves = "release"
  on = "pull_request"
}

action "login" {
  uses = "actions/heroku@master"
  args = "container:login"
  secrets = ["HEROKU_API_KEY"]
}

action "push" {
  uses = "actions/heroku@master"
  needs = "login"
  args = "container:push -a APP_NAME web"
  secrets = ["HEROKU_API_KEY"]
  env = {
    APP_NAME = "hermes-pd"
  }
}

action "release" {
  uses = "actions/heroku@master"
  needs = "push"
  args = "container:release -a APP_NAME web"
  secrets = ["HEROKU_API_KEY"]
  env = {
    APP_NAME = "hermes-pd"
  }
}
