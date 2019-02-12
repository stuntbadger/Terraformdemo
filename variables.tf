variable "region" {
 default = "eu-west-2"
}
variable "AmiLinux" {
 type = "map"
 default = {
 eu-west-2 = "ami-0209769f0c963e791"
 us-east-1 = "ami-b73b63a0"
 us-west-2 = "ami-5ec1673e" 
}
 description = "I added only 3 regions (Virginia, Oregon, London) to show the map feature but you can add all the regions"
}
variable "aws_access_key" {
 default = ""
 description = "the user aws access key"
}
variable "aws_secret_key" {
 default = ""
 description = "the user aws secret key"
}
variable "vpc-fullcidr" {
 default = "172.28.0.0/16"
 description = "the vpc cdir"
}
variable "Subnet-Public-AzA-CIDR" {
 default = "172.28.0.0/24"
 description = "the cidr of the subnet"
}
variable "Subnet-Private-AzA-CIDR" {
 default = "172.28.3.0/24"
 description = "the cidr of the subnet"
}
variable "key_name" {
 default = ""
 description = "The ssh key to use in the EC2 machines"
}
variable "DnsZoneName" {
 default = "jpenney.internal"
 description = "the internal dns name"
}
