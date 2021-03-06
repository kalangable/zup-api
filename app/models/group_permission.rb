class GroupPermission < ActiveRecord::Base
  include AtomicArrays

  class Boolean
  end

  TYPES_CLASSES = {
    flow: Flow,
    step: Step,
    user: User,
    group: Group,
    inventory: Inventory::Category,
    report: Reports::Category,
    business_report: BusinessReport
  }

  # Types of permissions
  TYPES = {
    flow: {
      'manage_flows' => Boolean,
      'flow_can_view_all_steps' => Array,
      'flow_can_execute_all_steps' => Array,
      'flow_can_delete_all_cases' => Array,
      'flow_can_delete_own_cases' => Array
    },

    step: {
      'can_view_step' => Array,
      'can_execute_step' => Array,
    },

    user: {
      'users_full_access' => Boolean
    },

    group: {
      'group_edit' => Array,
      'group_read_only' => Array,
      'groups_full_access' => Boolean,
      'users_edit' => Array
    },

    other: {
      'manage_config' => Boolean,
      'panel_access' => Boolean,
      'view_categories' => Boolean,
      'view_sections' => Boolean
    },

    inventory: {
      'inventories_items_create' => Array,
      'inventories_items_edit' => Array,
      'inventories_items_delete' => Array,
      'inventories_items_read_only' => Array,
      'inventories_categories_edit' => Array,
      'inventories_formulas_full_access' => Boolean,
      'inventories_full_access' => Boolean
    },

    report: {
      'reports_items_read_public' => Array,
      'reports_items_read_private' => Array,
      'reports_items_create' => Array,
      'reports_items_edit' => Array,
      'reports_items_delete' => Array,
      'reports_items_forward' => Array,
      'reports_items_create_internal_comment' => Array,
      'reports_items_create_comment' => Array,
      'reports_items_alter_status' => Array,
      'reports_items_send_notification' => Array,
      'reports_items_restart_notification' => Array,
      'reports_categories_edit' => Array,
      'reports_full_access' => Boolean,
      'manage_reports_categories' => Boolean
    },

    business_report: {
      'business_reports_edit' => Boolean,
      'business_reports_view' => Array
    }
  }

  belongs_to :group

  def self.permissions_columns
    %w(
      panel_access
      create_reports_from_panel
      users_full_access
      users_edit
      groups_full_access
      reports_full_access
      inventories_full_access
      inventories_formulas_full_access
      group_edit
      group_read_only
      reports_items_read_public
      reports_items_read_private
      reports_items_create
      reports_items_edit
      reports_items_delete
      reports_items_forward
      reports_items_create_internal_comment
      reports_items_create_comment
      reports_items_alter_status
      reports_items_send_notification
      reports_items_restart_notification
      reports_categories_edit
      manage_reports_categories
      inventories_items_read_only
      inventories_items_create
      inventories_items_edit
      inventories_items_delete
      inventories_categories_edit
      inventories_category_manage_triggers
      inventory_fields_can_edit
      inventory_fields_can_view
      inventory_sections_can_edit
      inventory_sections_can_view
      flow_can_execute_all_steps
      flow_can_delete_own_cases
      flow_can_delete_all_cases
      flow_can_view_all_steps
      can_view_step
      can_execute_step
      manage_flows
      manage_config
      create_reports_from_panel
      business_reports_edit
      business_reports_view
    )
  end
end
