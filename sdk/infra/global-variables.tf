##########
# GLOBAL #
##########

variable "profile" {
   type = "string"
 }

 variable "region" {
   type = "string"
 }

 variable "namespace" {
   type = "string"
 }

 variable "account-id" {
   type = "string"
 }


########
# TAGS #
########

variable "tags" {
  type    = "map"
  default = {
    BusinessUnit       = "ACME LTDA"
    ComplianceList     = ""
    ComplianceRequired = "0"
    CriticalLevel      = "9"
    Email              = "l-acme@acme.com"
    EscalationList     = "userid1/userid2/userid3"
    FilaIm             = "l-acme"
    Product            = "ACME Product"
    Slack              = "acme-prod"
    Team               = "acme-devops"
  }
}
