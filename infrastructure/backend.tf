terraform {
  backend "s3" {
    bucket       = "sanjid-particle41-tfstate"
    key          = "particle41timeservice/test/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
    encrypt      = true
  }
}