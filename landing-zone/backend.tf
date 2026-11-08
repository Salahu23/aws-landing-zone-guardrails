terraform {
  backend "s3" {
    bucket       = "salah-lz-tfstate-cdle4w"
    key          = "landing-zone/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
