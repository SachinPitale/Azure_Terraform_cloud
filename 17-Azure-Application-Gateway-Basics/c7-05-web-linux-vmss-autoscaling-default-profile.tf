#-----------------------------------------------
# Auto Scaling for Virtual machine scale set
#-----------------------------------------------
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting

/*
Resource: azurerm_monitor_autoscale_setting
- Notification Block
- Profile Block-1: Default Profile
  1. Capacity Block
  2. Percentage CPU Metric Rules
    1. Scale-Up Rule: Increase VMs by 1 when CPU usage is greater than 75%
    2. Scale-In Rule: Decrease VMs by 1when CPU usage is lower than 25%
  3. Available Memory Bytes Metric Rules
    1. Scale-Up Rule: Increase VMs by 1 when Available Memory Bytes is less than 1GB in bytes
    2. Scale-In Rule: Decrease VMs by 1 when Available Memory Bytes is greater than 2GB in bytes
  4. LB SYN Count Metric Rules (JUST FOR firing Scale-Up and Scale-In Events for Testing and also knowing in addition to current VMSS Resource, we can also create Autoscaling rules for VMSS based on other Resource usage like Load Balancer)
    1. Scale-Up Rule: Increase VMs by 1 when LB SYN Count is greater than 10 Connections (Average)
    2. Scale-Up Rule: Decrease VMs by 1 when LB SYN Count is less than 10 Connections (Average)    
*/


resource "azurerm_monitor_autoscale_setting" "web_vmss_autoscale" {
  name = "${local.resource_group_prefix}-web-vmss-autoscale"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  target_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id

  notification {
    email {
      send_to_subscription_administrator    = true
      send_to_subscription_co_administrator = true
      custom_emails                         = ["myadminteam@ourdomain.com"]
    }

  }


################################################################################
#######################  Profile-1: Default Profile  ###########################
################################################################################
# Profile-1: Default Profile 
  profile {
    name =  "default"
    capacity {
      default = 2
      minimum = 2
      maximum = 4
    }
###########  START: Percentage CPU Metric Rules  ###########    
   ## Scale-Out 
    rule {
      scale_action {
        direction = "Increase"
        cooldown = "PT5M"
        type = "ChangeCount"
        value = 1
     }
      metric_trigger {
        metric_name = "Percentage CPU"
        metric_namespace = "microsoft.compute/virtualmachinescalesets" 
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
        time_grain = "PT1M"
        statistic = "Average"
        time_window = "PT5M"
        time_aggregation = "Average"
        operator = "GreaterThan"
        threshold = 75
     }
   }
   ## Scale-In
    rule {
      scale_action {
        direction = "Decrease"
        cooldown = "PT5M"
        value = 1
        type = "ChangeCount"
     }
      metric_trigger {
        metric_name = "Percentage CPU"
        metric_namespace = "microsoft.compute/virtualmachinescalesets" 
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
        time_grain = "PT1M"
        statistic = "Average"
        time_window = "PT5M"
        time_aggregation = "Average"
        operator = "LessThan"
        threshold = 25
     }
   }
###########  END: Percentage CPU Metric Rules   ###########    
##########  START: Available Memory Bytes Metric Rules  ###########    
    ## Scale-Out 
    rule {
      scale_action {
        direction = "Increase"
        cooldown = "PT5M"
        value = 1
        type = "ChangeCount"
      }
      metric_trigger {
        metric_name = "Available Memory Bytes"
        metric_namespace = "microsoft.compute/virtualmachinescalesets" 
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
        time_grain = "PT1M"
        time_aggregation = "Average"
        time_window = "PT5M"
        statistic = "Average"
        operator = "LessThan"
        threshold = 1073741824 # Increase 1 VM when Memory In Bytes is less than 1GB

      }
    }
    ## Scale-In
    rule {
      scale_action {
        direction = "Decrease"
        cooldown = "PT5M"
        type = "ChangeCount"
        value = 1
      }
      metric_trigger {
        metric_name = "Available Memory Bytes"
        metric_namespace = "microsoft.compute/virtualmachinescalesets"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
        time_grain = "PT1M"
        statistic = "Average"
        time_aggregation = "Average"
        time_window = "PT5M"
        operator = "GreaterThan"
        threshold = 2147483648 # Decrease 1 VM when Memory In Bytes is Greater than 2GB

      }

    }
###########  END: Available Memory Bytes Metric Rules  ###########  
/*
###########  START: LB SYN Count Metric Rules - Just to Test scale-in, scale-out  ###########   
    ## Scale-Out 
    rule {
      scale_action {
        direction = "Increase"
        cooldown = "PT5M"
        value = 1
        type = "ChangeCount"
      }
      metric_trigger {
        metric_name = "SYNCount"
        metric_namespace = "Microsoft.Network/loadBalancers" 
        metric_resource_id = azurerm_lb.slb_web.id
        time_grain = "PT1M"
        statistic = "Average"
        time_window = "PT5M"
        time_aggregation = "Average"
        operator = "GreaterThan"
        threshold = 10 # 10 requests to an LB

      }
    }
    ## Scale-Out 
    rule {
      scale_action {
        direction = "Decrease"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M"
      }
      metric_trigger {
        metric_name = "SYNCount"
        metric_namespace = "Microsoft.Network/loadBalancers" 
        metric_resource_id = azurerm_lb.slb_web.id
        time_grain = "PT1M"
        time_aggregation = "Average"
        statistic = "Average"
        time_window = "PT5M"
        operator = "LessThan"
        threshold = 10
      }
    ###########  END: LB SYN Count Metric Rules  ###########  
    } # End of Profile-1
*/
  }
  





  
  
}

