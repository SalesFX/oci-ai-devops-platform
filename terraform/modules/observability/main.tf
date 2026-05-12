# Notification Topic
resource "oci_ons_notification_topic" "alerts" {
  compartment_id = var.compartment_id
  name           = "oci-devops-${var.env}-alerts"
  freeform_tags  = var.tags
}

resource "oci_ons_subscription" "email" {
  compartment_id = var.compartment_id
  endpoint       = var.notification_email
  protocol       = "EMAIL"
  topic_id       = oci_ons_notification_topic.alerts.id
  freeform_tags  = var.tags
}

# Log Group
resource "oci_logging_log_group" "main" {
  compartment_id = var.compartment_id
  display_name   = "oci-devops-${var.env}-logs"
  freeform_tags  = var.tags
}

# Alarm — CPU alta
resource "oci_monitoring_alarm" "high_cpu" {
  compartment_id        = var.compartment_id
  display_name          = "oci-devops-${var.env}-high-cpu"
  destinations          = [oci_ons_notification_topic.alerts.id]
  is_enabled            = true
  metric_compartment_id = var.compartment_id
  namespace             = "oci_computeagent"
  query                 = "CpuUtilization[5m].mean() > 80"
  severity              = "WARNING"
  freeform_tags         = var.tags
}

# Alarm — Memória alta
resource "oci_monitoring_alarm" "high_memory" {
  compartment_id        = var.compartment_id
  display_name          = "oci-devops-${var.env}-high-memory"
  destinations          = [oci_ons_notification_topic.alerts.id]
  is_enabled            = true
  metric_compartment_id = var.compartment_id
  namespace             = "oci_computeagent"
  query                 = "MemoryUtilization[5m].mean() > 90"
  severity              = "CRITICAL"
  freeform_tags         = var.tags
}
