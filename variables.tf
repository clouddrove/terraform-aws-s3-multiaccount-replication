#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-s3-multiaccount-replication"
  description = "Terraform current module repo"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = []
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'."
}

variable "attributes" {
  type        = list(any)
  default     = []
  description = "Additional attributes (e.g. `1`)."
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `organization`, `environment`, `name` and `attributes`."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "create_bucket" {
  type        = bool
  default     = true
  description = "Controls if S3 bucket should be created"
}

variable "attach_elb_log_delivery_policy" {
  type        = bool
  default     = false
  description = "Controls if S3 bucket should have ELB log delivery policy attached"
}

variable "attach_lb_log_delivery_policy" {
  type        = bool
  default     = false
  description = "Controls if S3 bucket should have ALB/NLB log delivery policy attached"
}

variable "attach_deny_insecure_transport_policy" {
  type        = bool
  default     = false
  description = "Controls if S3 bucket should have deny non-SSL transport policy attached"
}

variable "attach_require_latest_tls_policy" {
  type        = bool
  default     = false
  description = "Controls if S3 bucket should require the latest version of TLS"
}

variable "attach_policy" {
  type        = bool
  default     = false
  description = "Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy)"
}

variable "attach_public_policy" {
  type        = bool
  default     = true
  description = "Controls if a user defined public bucket policy will be attached (set to `false` to allow upstream to apply defaults to the bucket)"
}

variable "bucket" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name."
}

variable "bucket_prefix" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket."
}

variable "acl" {
  type        = string
  default     = "private"
  description = "(Optional) The canned ACL to apply. Defaults to 'private'. Conflicts with `grant`"
}

variable "policy" {
  type        = string
  default     = null
  description = "(Optional) A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
}

variable "acceleration_status" {
  type        = string
  default     = null
  description = "(Optional) Sets the accelerate configuration of an existing bucket. Can be Enabled or Suspended."
}

variable "request_payer" {
  type        = string
  default     = null
  description = "(Optional) Specifies who should bear the cost of Amazon S3 data transfer. Can be either BucketOwner or Requester. By default, the owner of the S3 bucket would incur the costs of any data transfer. See Requester Pays Buckets developer guide for more information."
}

variable "website" {
  type        = map(string)
  default     = {}
  description = "Map containing static web-site hosting or redirect configuration."
}

variable "cors_rule" {
  type        = any
  default     = []
  description = "List of maps containing rules for Cross-Origin Resource Sharing."
}

variable "versioning" {
  type        = map(string)
  default     = {}
  description = "Map containing versioning configuration."
}

variable "logging" {
  type        = map(string)
  default     = {}
  description = "Map containing access bucket logging configuration."
}

variable "grant" {
  type        = any
  default     = []
  description = "An ACL policy grant. Conflicts with `acl`"
}

variable "lifecycle_rule" {
  type        = any
  default     = []
  description = "List of maps containing configuration of object lifecycle management."
}

variable "replication_configuration" {
  type        = any
  default     = {}
  description = "Map containing cross-region replication configuration."
}

variable "server_side_encryption_configuration" {
  type        = any
  default     = {}
  description = "Map containing server-side encryption configuration."
}

variable "object_lock_configuration" {
  type        = any
  default     = {}
  description = "Map containing S3 object locking configuration."
}

variable "block_public_acls" {
  type        = bool
  default     = false
  description = "Whether Amazon S3 should block public ACLs for this bucket."
}

variable "block_public_policy" {
  type        = bool
  default     = false
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
}

variable "ignore_public_acls" {
  type        = bool
  default     = false
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
}

variable "restrict_public_buckets" {
  type        = bool
  default     = false
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
}

variable "control_object_ownership" {
  type        = bool
  default     = false
  description = "Whether to manage S3 Bucket Ownership Controls on this bucket."
}

variable "object_ownership" {
  type        = string
  default     = "ObjectWriter"
  description = "Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter. 'BucketOwnerEnforced': ACLs are disabled, and the bucket owner automatically owns and has full control over every object in the bucket. 'BucketOwnerPreferred': Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the bucket-owner-full-control canned ACL. 'ObjectWriter': The uploading account will own the object if the object is uploaded with the bucket-owner-full-control canned ACL."
}
