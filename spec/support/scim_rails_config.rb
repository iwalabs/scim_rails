# This file would normally be in config > initializers but
# is included here because it is essentially a spec helper

ScimRails.configure do |config|
  config.basic_auth_model = "Company"
  config.scim_users_model = "User"

  config.basic_auth_model_searchable_attribute = :subdomain
  config.basic_auth_model_authenticatable_attribute = :api_token

  ### ---------- Users ---------- ###
  config.scim_users_scope = :users
  config.scim_users_list_order = { created_at: :asc }

  config.user_deprovision_method = :archive!
  config.user_reprovision_method = :unarchive!

  config.mutable_user_attributes = [
    :first_name,
    :last_name,
    :email
  ]

  config.queryable_user_attributes = {
    userName: :email,
    givenName: :first_name,
    familyName: :last_name,
    email: :email
  }

  config.mutable_user_attributes_schema = {
    name: {
      givenName: :first_name,
      familyName: :last_name
    },
    emails: [
      {
        value: :email
      }
    ]
  }

  config.user_schema = {
    schemas: ["urn:ietf:params:scim:schemas:core:2.0:User"],
    id: :id,
    userName: :email,
    name: {
      givenName: :first_name,
      familyName: :last_name
    },
    emails: [
      {
        value: :email
      },
    ],
    active: :unarchived?
  }

  ### ---------- Groups ---------- ###
  config.scim_groups_scope = :groups
  config.scim_groups_list_order = { created_at: :asc }

  config.group_add_members_method = :add_members!
  config.group_remove_members_method = :remove_members!

  config.mutable_group_attributes = [
    :display_name
  ]

  config.queryable_group_attributes = {
    displayName: :display_name
  }

  config.mutable_group_attributes_schema = {
    displayName: :display_name
  }

  config.group_schema = {
    schemas: ["urn:ietf:params:scim:schemas:core:2.0:Group"],
    id: :id,
    displayName: :display_name,
    members: :members
  }
end
