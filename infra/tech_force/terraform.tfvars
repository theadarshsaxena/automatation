# region    = "us-west-2"
# project   = "matterworx"
# env       = "dev"
# createdBy = "otmusleh"

# DOMAIN
# domain_name     = "dev2.matterworxapp.com"
# acm_domain_name = "*.matterworxapp.com"

# ALB
# health_check_paths = ["/", "/api/assignment/health", "/api/control/health", "/api/sourcing/health", "/api/history/health"] # for target group health check path
# host_paths = [
#   ["/api/assignment/*", "/api/assignment"],
#   ["/api/control/*"],
#   ["/api/sourcing/*"],
#   ["/api/history/*"]
# ]


# target_group_ports = [3000, 80, 80, 80, 80]

# ECS
# ecs_cluster_name = "dev-matterworx"
# ecs_ports        = [3000, 80, 80, 80, 80]
all_names = {
  ecs_service_names         = ["dev-frontend-service", "dev-assignment-service", "dev-controlpanel-service", "dev-sourcing-service", "dev-history-service"]
  sidecar_container_name    = ["dev-frontend-fluentbit", "dev-assignment-fluentbit", "dev-controlpanel-fluentbit", "dev-sourcing-fluentbit", "dev-history-fluentbit"]
  ecs_task_definition_names = ["dev-frontend-task", "dev-assignment-task", "dev-controlpanel-task", "dev-sourcing-task", "dev-history-task"]
  alb_target_group_names    = ["dev-frontend-tg", "dev-assignment-tg", "dev-controlpanel-tg", "dev-sourcing-tg", "dev-history-tg"]
}
# elastic_search_domain = "monitor.matterworxapp.com" #"search-dev-monitoring-wpgl642tmwmfsevj5hltjem5ba.us-west-2.es.amazonaws.com"

# task_env_files = [
#   # [{
#   #   type = "s3"
#   #   value = "value" # ENV file path
#   # }]
# ]