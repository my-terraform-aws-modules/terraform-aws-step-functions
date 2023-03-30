output "state_machine_id" {
  description = "The ID of the Step Function"
  value       = try(aws_sfn_state_machine.sfn_state_machine[0].id, "")
}

output "state_machine_arn" {
  description = "The ARN of the Step Function"
  value       = try(aws_sfn_state_machine.sfn_state_machine[0].arn, "")
}