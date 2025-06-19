variables {
  name = "my-vpc"
}

run "name_validation" {
  command = plan

  assert {
    condition     = module.vpc.vpc_tags["Name"] == var.usecase_no-vpc
    error_message = "TEST_ERROR: VPC name is not as expected"
  }
}