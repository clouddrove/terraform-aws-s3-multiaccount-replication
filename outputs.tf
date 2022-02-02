output "s3_bucket_id" {
  value       = element(concat(aws_s3_bucket_policy.this.*.id, aws_s3_bucket.this.*.id, [""]), 0)
  description = "The name of the bucket."
}

output "s3_bucket_arn" {
  value       = element(concat(aws_s3_bucket.this.*.arn, [""]), 0)
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
}

output "s3_bucket_bucket_domain_name" {
  value       = element(concat(aws_s3_bucket.this.*.bucket_domain_name, [""]), 0)
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
}

output "s3_bucket_bucket_regional_domain_name" {
  value       = element(concat(aws_s3_bucket.this.*.bucket_regional_domain_name, [""]), 0)
  description = "The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL."
}

output "s3_bucket_hosted_zone_id" {
  value       = element(concat(aws_s3_bucket.this.*.hosted_zone_id, [""]), 0)
  description = "The Route 53 Hosted Zone ID for this bucket's region."
}

output "s3_bucket_region" {
  value       = element(concat(aws_s3_bucket.this.*.region, [""]), 0)
  description = "The AWS region this bucket resides in."
}

output "s3_bucket_website_endpoint" {
  value       = element(concat(aws_s3_bucket.this.*.website_endpoint, [""]), 0)
  description = "The website endpoint, if the bucket is configured with a website. If not, this will be an empty string."
}

output "s3_bucket_website_domain" {
  value       = element(concat(aws_s3_bucket.this.*.website_domain, [""]), 0)
  description = "The domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string. This is used to create Route 53 alias records. "
}

output "tags" {
  value       = module.labels.tags
  description = "A mapping of tags to assign to the resource."
}