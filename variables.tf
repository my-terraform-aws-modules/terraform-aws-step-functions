# Common variables
variable "region" {
  type = string
  default = "eu-west-1"
}
variable "create_sfn" {
  type = bool
  default = true
}
variable "environment" {
  description = "The environment to deploy to."
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "prod", "sit", "snd", "uat"], var.environment)
    error_message = "Valid values for var: environment are (dev, prod, sit, snd, uat)."
  }
}
variable "state_machine_name" {
  type = string
  default = "demostepfunction"
}


variable "type" {
  type        = string
  description = "Determines whether a Standard or Express state machine is created."
  default = "Standard"
}

variable "include_execution_data" {
  type        = bool
  description = "Determines whether execution data is included in your log. When set to false, data is excluded."
  default = false
}
variable "logging_configuration_level" {
  type        = string
  description = "Defines which category of execution history events are logged. Valid values: ALL, ERROR, FATAL, OFF"
  default = "ALL"
  validation {
    condition = contains([
      "ALL", "ERROR", "FATAL", "OFF"
    ], var.logging_configuration_level)
    error_message = "Must be one of the allowed values."
  }
}
variable "state_machine_tags" {
  description = "The tags provided by the client module. To be merged with internal tags"
  type        = map(string)
  default     = {}
}
variable "xray_tracing_enabled" {
  type        = bool
  description = "When set to true, AWS X-Ray tracing is enabled."
  default     = true
}

variable "cloudwatch_log_group_name" {
  type        = string
  description = "The name of the Cloudwatch log group."
  default = "demologgroup"
}

variable "cloudwatch_log_group_tags" {
  description = "The tags provided by the client module. To be merged with internal tags"
  type        = map(string)
  default     = {}
}
variable "enable_sfn_encyption" {
  type = bool
  default = false  
}
variable "cloudwatch_log_group_kms_key_arn" {
  type        = string
  description = "The ARN of the KMS Key to use when encrypting log data."
  default = ""
}
variable "cloudwatch_log_group_retention_days" {
  type        = number
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653, and 0. If you select 0, the events in the log group are always retained and never expire."
  default = 1
  validation {
    condition = contains([
      0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653
    ], var.cloudwatch_log_group_retention_days)
    error_message = "Must be one of the allowed values."
  }
}

variable "step_function_defination" {
  type        = string
  description = "The name of the file that contains the state machine definition. File should be in JSON format."
  default = ""
}

variable "policy_file_name" {
  type        = string
  description = "The name of the file that contains the iam policy. File should be in JSON format."
  default = ""
}
variable "create_sfn_role" {
  type = bool
  default = true
}
variable "custom_sfn_role" {
  type = string
  default = ""
}
variable "sfn_iam_role_name" {
  type        = string
  description = "The name given to the iam role used by the state machine."
  default = "demo-sfn-role"
}
variable "create_sfn_logging_policy" {
  type = bool
  default = true 
}
variable "create_sfn_statemachine_policy" {
  type = bool
  default = true 
}
variable "create_xray_tracing_policy" {
  type = bool
  default = true 
}