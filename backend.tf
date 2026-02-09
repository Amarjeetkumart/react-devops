terraform {
  backend "s3" {
    bucket         = "terraform-state-devops-project-12345"
    key            = "react-devops/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
