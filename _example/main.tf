locals {
  bucket_name             = "origin-s3-bucket-test"
  destination_bucket_name = "replica-s3-bucket-test"
  origin_region           = "eu-west-1"
  replica_region          = "eu-central-1"
  source_root_user_arn    = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
}

provider "aws" {
  region = local.origin_region
}

provider "aws" {
  region  = local.replica_region
  alias   = "replica"
  profile = "deepak"
}

data "aws_caller_identity" "current" {}
data "aws_caller_identity" "dest" {
  provider = aws.replica
}


data "aws_iam_policy_document" "dest_bucket_policy" {
  statement {
    sid = "1"

    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete"
    ]

    resources = [
      "arn:aws:s3:::${local.destination_bucket_name}/*"
    ]

    principals {
      type = "AWS"

      identifiers = [
        aws_iam_role.replication.arn
      ]
    }
  }
  statement {
    sid = "2"

    actions = [

      "s3:ObjectOwnerOverrideToBucketOwner"
    ]

    resources = [
      "arn:aws:s3:::${local.destination_bucket_name}/*"
    ]

    principals {
      type = "AWS"

      identifiers = [
        local.source_root_user_arn
      ]
    }
  }

  statement {
    sid = "3"

    actions = [
      "s3:GetBucketVersioning",
      "s3:PutBucketVersioning"
    ]

    resources = [
      "arn:aws:s3:::${local.destination_bucket_name}"
    ]

    principals {
      type = "AWS"

      identifiers = [
        aws_iam_role.replication.arn
      ]
    }
  }
}

module "replica_bucket" {
  source = "./../"

  providers = {
    aws = aws.replica
  }

  bucket        = local.destination_bucket_name
  environment   = "test"
  acl           = "private"
  attach_policy = true
  policy        = data.aws_iam_policy_document.dest_bucket_policy.json

  versioning = {
    enabled = true
  }
}

module "s3_bucket" {
  source = "./../"

  bucket      = local.bucket_name
  environment = "test"
  acl         = "private"

  versioning = {
    enabled = true
  }

  replication_configuration = {
    role = aws_iam_role.replication.arn

    rules = [


      {
        id       = "everything-with-filter"
        status   = "Enabled"
        priority = 1

        destination = {
          bucket        = "arn:aws:s3:::${local.destination_bucket_name}"
          storage_class = "STANDARD"
          filter = {
            prefix = ""
          }
          account_id = data.aws_caller_identity.dest.account_id
          access_control_translation = {
            owner = "Destination"
          }
        }
      }
    ]
  }

}
