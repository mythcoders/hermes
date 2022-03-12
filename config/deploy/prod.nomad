job "hermes" {
  datacenters = ["mcdig"]

  meta {
    version = "2203"
  }

  update {
    max_parallel      = 1
    health_check      = "checks"
    min_healthy_time  = "20s"
    healthy_deadline  = "3m"
    progress_deadline = "10m"
    auto_revert       = true
    auto_promote      = true
    canary            = 2
    stagger           = "30s"
  }

  group "app" {
    count = 2

    constraint {
      attribute = "${node.class}"
      operator  = "="
      value     = "app"
    }

    network {
      mode = "bridge"
      port "puma" {
        to = 5000
      }
    }

    service {
      name = "hermes-rails"
      port = "puma"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.hermes.rule=Host(`hermes.mythcoders.net`)",
        "traefik.http.routers.hermes.tls=true",
        "traefik.http.routers.hermes.tls.certresolver=letsEncrypt",
      ]

      connect {
        sidecar_service {
          proxy {
            local_service_address = "0.0.0.0"
            local_service_port = 5000
          }
        }
      }

      check {
        name     = "heartbeat"
        type     = "http"
        path     = "/_heartbeat"
        interval = "10s"
        timeout  = "3s"
      }
    }

    task "rails" {
      driver = "docker"

      config {
        image = "ghcr.io/mythcoders/hermes:latest"
        ports = ["puma"]
      }

      template {
        data = <<EOH
      RAILS_MASTER_KEY="{{ key "hermes/rails-master-key" }}"
      DATABASE_URL="{{ key "hermes/database-url" }}"
      NODE_ENVIRONMENT="production"
      ENVIRONMENT_NAME="production"
      GITLAB_ENVIRONMENT_URL="hermes.mythcoders.net"
      ENVIRONMENT_URL="hermes.mythcoders.net"
      RAILS_ENV="production"
      RAILS_LOG_TO_STDOUT="1"
      REDIS_WORKER_NAMESPACE="{{ env "NOMAD_JOB_NAME" }}"
      RAILS_SERVE_STATIC_FILES="1"
      STORAGE_BUCKET="mcdig-pdstg-hermes"
      REDIS_URL="{{ key "hermes/redis-url" }}"
      EOH

        destination = "secrets/vault.env"
        env         = true
      }
    }

    task "db-migrate" {
      lifecycle {
        hook = "prestart"
        sidecar = false
      }

      driver = "docker"

      config {
        image = "ghcr.io/mythcoders/hermes:latest"
        entrypoint = ["./bin/rails", "db:migrate"]
        ports = ["puma"]
      }

      template {
        data = <<EOH
      RAILS_MASTER_KEY="{{ key "hermes/rails-master-key" }}"
      DATABASE_URL="{{ key "hermes/database-url" }}"
      NODE_ENVIRONMENT="production"
      ENVIRONMENT_NAME="production"
      GITLAB_ENVIRONMENT_URL="hermes.mythcoders.net"
      ENVIRONMENT_URL="hermes.mythcoders.net"
      RAILS_ENV="production"
      RAILS_LOG_TO_STDOUT="1"
      REDIS_WORKER_NAMESPACE="{{ env "NOMAD_JOB_NAME" }}"
      RAILS_SERVE_STATIC_FILES="1"
      STORAGE_BUCKET="mcdig-pdstg-hermes"
      REDIS_URL="{{ key "hermes/redis-url" }}"
      EOH

        destination = "secrets/vault.env"
        env         = true
      }
    }
  }

  group "workers" {
    constraint {
      attribute = "${node.class}"
      operator  = "="
      value     = "job"
    }

    network {
      mode = "bridge"
    }

    service {
      name = "hermes-sidekiq"
    }

    task "sidekiq" {
      driver = "docker"

      template {
        data = <<EOH
      RAILS_MASTER_KEY="{{ key "hermes/rails-master-key" }}"
      DATABASE_URL="{{ key "hermes/database-url" }}"
      NODE_ENVIRONMENT="production"
      ENVIRONMENT_NAME="production"
      GITLAB_ENVIRONMENT_URL="hermes.mythcoders.net"
      ENVIRONMENT_URL="hermes.mythcoders.net"
      RAILS_ENV="production"
      RAILS_LOG_TO_STDOUT="1"
      REDIS_WORKER_NAMESPACE="{{ env "NOMAD_JOB_NAME" }}"
      RAILS_SERVE_STATIC_FILES="1"
      STORAGE_BUCKET="mcdig-pdstg-hermes"
      REDIS_URL="{{ key "hermes/redis-url" }}"
      EOH

        destination = "secrets/vault.env"
        env         = true
      }

      config {
        image = "ghcr.io/mythcoders/hermes:latest"
        entrypoint = ["sh", "./scripts/worker", "start"]
      }
    }
  }
}
