resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alerm" {
  alarm_name                = "cpu_utilization_alerm_50"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "50"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
}