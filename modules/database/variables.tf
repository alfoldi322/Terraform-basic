variable "vpc_id" {
    default = "module.network.outputs.vpc_id"
}
variable "private_subnet_id" {
    default = "module.network.outputs.private_subnet_id"
}
variable "java_sg_id" {
    default = "data.module.java.outputs.java_sg_id"
}