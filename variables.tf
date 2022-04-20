variable "access_key" {
     description = "Access key to AWS console"

}
variable "secret_key" {
     description = "Secret key to AWS console"

}

variable "region" {
  default     = "us-east-2"
  type        = string
  description = "Region of the VPC"
}

variable "prod-blisslogs-bucket-name" {
  default     = "jaga-prod.blisslogs"
  type        = string
  description = "NAME OF prod.blisslogs S3 BUCKET"
}

variable "ssh-recodringlogs-bucket-name" {
  default     = "jaga-ssh-recodringlogs"
  type        = string
  description = "NAME OF ssh-recodringlogs S3 BUCKET"
}

variable "c5-bliss-trail-n-virginia" {
  default     = "jaga-c5-bliss-trail-n-virginia"
  type        = string
  description = "NAME OF c5-bliss-trail-n-virginia S3 BUCKET"
}
