variable "ecr_info" {
  type = object({
    name                 = string
    force_delete         = bool
    image_tag_mutability = string
    scan_on_push         = bool
    countNumber          = number
  })
}