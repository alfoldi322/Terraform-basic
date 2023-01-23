variable "vpc_id" {
    default = "module.network.outputs.vpc_id"
}
variable "public_subnet_id" {
    default = "module.network.outputs.public_subnet_id"
}
variable "security_group_id" {
    type    = string
    default = "java"
}