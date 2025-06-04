variable "bastion_host_name" {
  description = "(Required) The name of the Bastion Host"
  type        = string
}

variable "sku" {
  description = "(Optional) Accepted values are Developer, Basic, Standard and Premium."
  type        = string
  default     = "Basic"

#  validation {
#    condition     = var.sku != "Developer"
#    error_message = "Developer SKU is not currently available in Canada"
#  }
}

variable "copy_paste_enabled" {
  description = "(Optional) Is Copy/Paste feature enabled for the Bastion Host. Defaults to true."
  type        = bool
  default     = true
}

variable "file_copy_enabled" {
  description = "(Optional) Is File Copy feature enabled for the Bastion Host. Defaults to false."
  type        = bool
  default     = null

  validation {
    condition = (
      (var.file_copy_enabled == null || var.file_copy_enabled == false) ||
      (var.file_copy_enabled == true && var.sku == "Standard" || var.sku == "Premium")
    )
    error_message = "file_copy_enabled is only supported when sku is Standard or Premium"
  }
}

variable "ip_connect_enabled" {
  description = "(Optional) Is IP Connect feature enabled for the Bastion Host. Defaults to false."
  type        = bool
  default     = null

  validation {
    condition = (
      (var.ip_connect_enabled == null || var.ip_connect_enabled == false) ||
      (var.ip_connect_enabled == true && var.sku == "Standard" || var.sku == "Premium")
    )
    error_message = "ip_connect_enabled is only supported when sku is Standard or Premium"
  }
}

variable "kerberos_enabled" {
  description = "(Optional) Is Kerberos feature enabled for the Bastion Host. Defaults to false."
  type        = bool
  default     = null

  validation {
    condition = (
      (var.kerberos_enabled == null || var.kerberos_enabled == false) ||
      (var.kerberos_enabled == true && var.sku == "Standard" || var.sku == "Premium")
    )
    error_message = "kerberos_enabled is only supported when sku is Standard or Premium"
  }
}

variable "shareable_link_enabled" {
  description = "(Optional) Is Shareable Link feature enabled for the Bastion Host. Defaults to false."
  type        = bool
  default     = null

  validation {
    condition = (
      (var.shareable_link_enabled == null || var.shareable_link_enabled == false) ||
      (var.shareable_link_enabled == true && var.sku == "Standard" || var.sku == "Premium")
    )
    error_message = "shareable_link_enabled is only supported when sku is Standard or Premium"
  }
}

variable "tunneling_enabled" {
  description = "(Optional) Enable tunneling through the Bastion Host"
  type        = bool
  default     = null

  validation {
    condition = (
      (var.tunneling_enabled == null || var.tunneling_enabled == false) ||
      (var.tunneling_enabled == true && var.sku == "Standard" || var.sku == "Premium")
    )
    error_message = "tunneling_enabled is only supported when sku is Standard or Premium"
  }
}

variable "session_recording_enabled" {
  description = "(Optional) Enable session recording for the Bastion Host"
  type        = bool
  default     = null

  validation {
    condition = (
      (var.session_recording_enabled == null || var.session_recording_enabled == false) ||
      (var.session_recording_enabled == true && var.sku == "Premium")
    )
    error_message = "session_recording_enabled is only supported when sku is Premium."
  }
}
