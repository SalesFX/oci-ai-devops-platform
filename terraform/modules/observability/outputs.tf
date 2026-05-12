output "notification_topic_id" {
  description = "OCID do tópico de notificações"
  value       = oci_ons_notification_topic.alerts.id
}

output "log_group_id" {
  description = "OCID do Log Group"
  value       = oci_logging_log_group.main.id
}
