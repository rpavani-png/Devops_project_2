output "vm_name" {
  value = google_compute_instance.vm.name
}

output "bucket_name" {
  value = google_storage_bucket.bucket.name
}