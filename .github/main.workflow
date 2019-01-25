workflow "Deploy to Heroku" {
  on = "push"
  resolves = [
    "verify-test",
    "verify-production"
  ]
}

# Login
action "login" {
  uses = "actions/heroku@master"
  args = "container:login"
  secrets = ["HEROKU_API_KEY"]
}

# Push
action "push-test" {
  needs = ["login"]
  uses = "actions/heroku@master"
  args = ["container:push", "--app", "$HEROKU_APP", "web"]
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "hermes-ts"
  }
}

# Release
action "release-test" {
  needs = ["push-test"]
  uses = "actions/heroku@master"
  args = ["container:release", "--app", "$HEROKU_APP", "web"]
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "hermes-ts"
  }
}

# Migrate
action "db-test" {
  needs = ["release-test"]
  uses = "actions/heroku@master"
  args = ["run", "bundle", "exec", "rails", "db:migrate", "--type", "web", "--app", "$HEROKU_APP"]
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "hermes-ts"
  }
}

# Verify
action "verify-test" {
  needs = ["db-test"]
  uses = "actions/heroku@master"
  args = ["apps:info", "$HEROKU_APP"]
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "hermes-ts"
  }
}

# Push to master
action "master-branch-filter" {
  needs = ["verify-test"]
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "push-production" {
  needs = ["master-branch-filter"]
  uses = "actions/heroku@master"
  args = ["container:push", "--app", "$HEROKU_APP", "web"]
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "hermes-pd"
  }
}

action "release-production" {
  needs = ["push-production"]
  uses = "actions/heroku@master"
  args = ["container:release", "--app", "$HEROKU_APP", "web"]
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "hermes-pd"
  }
}

action "db-production" {
  needs = ["release-production"]
  uses = "actions/heroku@master"
  args = ["run", "bundle", "exec", "rails", "db:migrate", "--type", "web", "--app", "$HEROKU_APP"]
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "hermes-pd"
  }
}

action "verify-production" {
  needs = ["db-production"]
  uses = "actions/heroku@master"
  args = ["apps:info", "$HEROKU_APP"]
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "hermes-pd"
  }
}
