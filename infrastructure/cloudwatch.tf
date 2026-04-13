resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${local.name}"
  retention_in_days = 7

  tags = merge(local.tags, {
    Name = "${local.name}-logs"
  })
}