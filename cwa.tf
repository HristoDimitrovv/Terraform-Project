resource "aws_cloudwatch_metric_alarm" "web_cwa" {
  alarm_name          = "web-cwa"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  threshold           = "1000"
  alarm_description   = "Number of requests has exceeded 1000"
  actions_enabled     = true

  metric_query {
    id = "m1"
    return_data = true

    metric {
      metric_name = "RequestCount"
      namespace   = "ApplicationELB"
      period      = "60"
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        LoadBalancer = "app/web"
      }
    }
  }

  tags = {
    Project     = var.project
    Environment = var.environment
  }

}

