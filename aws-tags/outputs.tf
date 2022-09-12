output "tags" {
  description = "Map of tags"
  value       = local.merged_tags
}

output "s3objtags" {
  description = "Map of tags"
  value       = local.merged_s3_obj_tags
}

# Currently we don't have any ASGs in the project. When we have it we can uncomment these lines.
# output "tags_asg" {
#   description = "Tags suitable for ASGs"
#   value       = "${null_resource.tags.*.triggers}"
# }