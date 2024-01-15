variable "RDS_subnets_id" {
  type = list(string)
}


variable "sg_id" {
  type = string
}

variable "rds_info" {
  type = object({
    allocated_storage         = number
    db_name                   = string
    engine                    = string
    engine_version            = string
    instance_class            = string
    username                  = string
    password                  = string
    subnet-group-name         = string
    backup_retention_period   = number
    skip_final_snapshot       = bool
    # final_snapshot_identifier = string
    tag                       = string
  })
}