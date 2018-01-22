# Copyright 2015 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'google/apis/core/base_service'
require 'google/apis/core/json_representation'
require 'google/apis/core/hashable'
require 'google/apis/errors'

module Google
  module Apis
    module DlpV2beta2
      # DLP API
      #
      # The Google Data Loss Prevention API provides methods for detection of privacy-
      #  sensitive fragments in text, images, and Google Cloud Platform storage
      #  repositories.
      #
      # @example
      #    require 'google/apis/dlp_v2beta2'
      #
      #    Dlp = Google::Apis::DlpV2beta2 # Alias the module
      #    service = Dlp::DLPService.new
      #
      # @see https://cloud.google.com/dlp/docs/
      class DLPService < Google::Apis::Core::BaseService
        # @return [String]
        #  API key. Your API key identifies your project and provides you with API access,
        #  quota, and reports. Required unless you provide an OAuth 2.0 token.
        attr_accessor :key

        # @return [String]
        #  Available to use for quota purposes for server-side applications. Can be any
        #  arbitrary string assigned to a user, but should not exceed 40 characters.
        attr_accessor :quota_user

        def initialize
          super('https://dlp.googleapis.com/', '')
          @batch_path = 'batch'
        end
        
        # Returns sensitive information types DLP supports.
        # @param [String] filter
        #   Optional filter to only return infoTypes supported by certain parts of the
        #   API. Defaults to supported_by=INSPECT.
        # @param [String] language_code
        #   Optional BCP-47 language code for localized infoType friendly
        #   names. If omitted, or if localized strings are not available,
        #   en-US strings will be returned.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListInfoTypesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListInfoTypesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_info_types(filter: nil, language_code: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v2beta2/infoTypes', options)
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListInfoTypesResponse::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListInfoTypesResponse
          command.query['filter'] = filter unless filter.nil?
          command.query['languageCode'] = language_code unless language_code.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates an Deidentify template for re-using frequently used configuration
        # for Deidentifying content, images, and storage.
        # @param [String] parent
        #   The parent resource name, for example projects/my-project-id or
        #   organizations/my-org-id.
        # @param [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2CreateDeidentifyTemplateRequest] google_privacy_dlp_v2beta2_create_deidentify_template_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_organization_deidentify_template(parent, google_privacy_dlp_v2beta2_create_deidentify_template_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v2beta2/{+parent}/deidentifyTemplates', options)
          command.request_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2CreateDeidentifyTemplateRequest::Representation
          command.request_object = google_privacy_dlp_v2beta2_create_deidentify_template_request_object
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes inspect templates.
        # @param [String] name
        #   Resource name of the organization and deidentify template to be deleted,
        #   for example `organizations/433245324/deidentifyTemplates/432452342`.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GoogleProtobufEmpty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GoogleProtobufEmpty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_organization_deidentify_template(name, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:delete, 'v2beta2/{+name}', options)
          command.response_representation = Google::Apis::DlpV2beta2::GoogleProtobufEmpty::Representation
          command.response_class = Google::Apis::DlpV2beta2::GoogleProtobufEmpty
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets an inspect template.
        # @param [String] name
        #   Resource name of the organization and deidentify template to be read, for
        #   example `organizations/433245324/deidentifyTemplates/432452342`.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_organization_deidentify_template(name, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v2beta2/{+name}', options)
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists inspect templates.
        # @param [String] parent
        #   The parent resource name, for example projects/my-project-id or
        #   organizations/my-org-id.
        # @param [Fixnum] page_size
        #   Optional size of the page, can be limited by server. If zero server returns
        #   a page of max size 100.
        # @param [String] page_token
        #   Optional page token to continue retrieval. Comes from previous call
        #   to `ListDeidentifyTemplates`.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListDeidentifyTemplatesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListDeidentifyTemplatesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_organization_deidentify_templates(parent, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v2beta2/{+parent}/deidentifyTemplates', options)
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListDeidentifyTemplatesResponse::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListDeidentifyTemplatesResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates the inspect template.
        # @param [String] name
        #   Resource name of organization and deidentify template to be updated, for
        #   example `organizations/433245324/deidentifyTemplates/432452342`.
        # @param [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2UpdateDeidentifyTemplateRequest] google_privacy_dlp_v2beta2_update_deidentify_template_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_organization_deidentify_template(name, google_privacy_dlp_v2beta2_update_deidentify_template_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:patch, 'v2beta2/{+name}', options)
          command.request_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2UpdateDeidentifyTemplateRequest::Representation
          command.request_object = google_privacy_dlp_v2beta2_update_deidentify_template_request_object
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates an inspect template for re-using frequently used configuration
        # for inspecting content, images, and storage.
        # @param [String] parent
        #   The parent resource name, for example projects/my-project-id or
        #   organizations/my-org-id.
        # @param [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2CreateInspectTemplateRequest] google_privacy_dlp_v2beta2_create_inspect_template_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_organization_inspect_template(parent, google_privacy_dlp_v2beta2_create_inspect_template_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v2beta2/{+parent}/inspectTemplates', options)
          command.request_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2CreateInspectTemplateRequest::Representation
          command.request_object = google_privacy_dlp_v2beta2_create_inspect_template_request_object
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes inspect templates.
        # @param [String] name
        #   Resource name of the organization and inspectTemplate to be deleted, for
        #   example `organizations/433245324/inspectTemplates/432452342`.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GoogleProtobufEmpty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GoogleProtobufEmpty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_organization_inspect_template(name, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:delete, 'v2beta2/{+name}', options)
          command.response_representation = Google::Apis::DlpV2beta2::GoogleProtobufEmpty::Representation
          command.response_class = Google::Apis::DlpV2beta2::GoogleProtobufEmpty
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets an inspect template.
        # @param [String] name
        #   Resource name of the organization and inspectTemplate to be read, for
        #   example `organizations/433245324/inspectTemplates/432452342`.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_organization_inspect_template(name, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v2beta2/{+name}', options)
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists inspect templates.
        # @param [String] parent
        #   The parent resource name, for example projects/my-project-id or
        #   organizations/my-org-id.
        # @param [Fixnum] page_size
        #   Optional size of the page, can be limited by server. If zero server returns
        #   a page of max size 100.
        # @param [String] page_token
        #   Optional page token to continue retrieval. Comes from previous call
        #   to `ListInspectTemplates`.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListInspectTemplatesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListInspectTemplatesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_organization_inspect_templates(parent, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v2beta2/{+parent}/inspectTemplates', options)
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListInspectTemplatesResponse::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListInspectTemplatesResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates the inspect template.
        # @param [String] name
        #   Resource name of organization and inspectTemplate to be updated, for
        #   example `organizations/433245324/inspectTemplates/432452342`.
        # @param [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2UpdateInspectTemplateRequest] google_privacy_dlp_v2beta2_update_inspect_template_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_organization_inspect_template(name, google_privacy_dlp_v2beta2_update_inspect_template_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:patch, 'v2beta2/{+name}', options)
          command.request_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2UpdateInspectTemplateRequest::Representation
          command.request_object = google_privacy_dlp_v2beta2_update_inspect_template_request_object
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # De-identifies potentially sensitive info from a ContentItem.
        # This method has limits on input size and output size.
        # [How-to guide](/dlp/docs/deidentify-sensitive-data)
        # @param [String] parent
        #   The parent resource name, for example projects/my-project-id.
        # @param [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyContentRequest] google_privacy_dlp_v2beta2_deidentify_content_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyContentResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyContentResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def deidentify_project_content(parent, google_privacy_dlp_v2beta2_deidentify_content_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v2beta2/{+parent}/content:deidentify', options)
          command.request_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyContentRequest::Representation
          command.request_object = google_privacy_dlp_v2beta2_deidentify_content_request_object
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyContentResponse::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyContentResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Finds potentially sensitive info in content.
        # This method has limits on input size, processing time, and output size.
        # [How-to guide for text](/dlp/docs/inspecting-text), [How-to guide for
        # images](/dlp/docs/inspecting-images)
        # @param [String] parent
        #   The parent resource name, for example projects/my-project-id.
        # @param [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectContentRequest] google_privacy_dlp_v2beta2_inspect_content_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectContentResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectContentResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def inspect_project_content(parent, google_privacy_dlp_v2beta2_inspect_content_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v2beta2/{+parent}/content:inspect', options)
          command.request_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectContentRequest::Representation
          command.request_object = google_privacy_dlp_v2beta2_inspect_content_request_object
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectContentResponse::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectContentResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Re-identify content that has been de-identified.
        # @param [String] parent
        #   The parent resource name.
        # @param [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ReidentifyContentRequest] google_privacy_dlp_v2beta2_reidentify_content_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ReidentifyContentResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ReidentifyContentResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def reidentify_project_content(parent, google_privacy_dlp_v2beta2_reidentify_content_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v2beta2/{+parent}/content:reidentify', options)
          command.request_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ReidentifyContentRequest::Representation
          command.request_object = google_privacy_dlp_v2beta2_reidentify_content_request_object
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ReidentifyContentResponse::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ReidentifyContentResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Schedules a job to compute risk analysis metrics over content in a Google
        # Cloud Platform repository. [How-to guide`(/dlp/docs/compute-risk-analysis)
        # @param [String] parent
        #   The parent resource name, for example projects/my-project-id.
        # @param [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2AnalyzeDataSourceRiskRequest] google_privacy_dlp_v2beta2_analyze_data_source_risk_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DlpJob] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DlpJob]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def analyze_project_data_source(parent, google_privacy_dlp_v2beta2_analyze_data_source_risk_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v2beta2/{+parent}/dataSource:analyze', options)
          command.request_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2AnalyzeDataSourceRiskRequest::Representation
          command.request_object = google_privacy_dlp_v2beta2_analyze_data_source_risk_request_object
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DlpJob::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DlpJob
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Schedules a job scanning content in a Google Cloud Platform data
        # repository. [How-to guide](/dlp/docs/inspecting-storage)
        # @param [String] parent
        #   The parent resource name, for example projects/my-project-id.
        # @param [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectDataSourceRequest] google_privacy_dlp_v2beta2_inspect_data_source_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DlpJob] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DlpJob]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def inspect_project_data_source(parent, google_privacy_dlp_v2beta2_inspect_data_source_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v2beta2/{+parent}/dataSource:inspect', options)
          command.request_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectDataSourceRequest::Representation
          command.request_object = google_privacy_dlp_v2beta2_inspect_data_source_request_object
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DlpJob::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DlpJob
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates an Deidentify template for re-using frequently used configuration
        # for Deidentifying content, images, and storage.
        # @param [String] parent
        #   The parent resource name, for example projects/my-project-id or
        #   organizations/my-org-id.
        # @param [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2CreateDeidentifyTemplateRequest] google_privacy_dlp_v2beta2_create_deidentify_template_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_project_deidentify_template(parent, google_privacy_dlp_v2beta2_create_deidentify_template_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v2beta2/{+parent}/deidentifyTemplates', options)
          command.request_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2CreateDeidentifyTemplateRequest::Representation
          command.request_object = google_privacy_dlp_v2beta2_create_deidentify_template_request_object
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes inspect templates.
        # @param [String] name
        #   Resource name of the organization and deidentify template to be deleted,
        #   for example `organizations/433245324/deidentifyTemplates/432452342`.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GoogleProtobufEmpty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GoogleProtobufEmpty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_project_deidentify_template(name, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:delete, 'v2beta2/{+name}', options)
          command.response_representation = Google::Apis::DlpV2beta2::GoogleProtobufEmpty::Representation
          command.response_class = Google::Apis::DlpV2beta2::GoogleProtobufEmpty
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets an inspect template.
        # @param [String] name
        #   Resource name of the organization and deidentify template to be read, for
        #   example `organizations/433245324/deidentifyTemplates/432452342`.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_deidentify_template(name, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v2beta2/{+name}', options)
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists inspect templates.
        # @param [String] parent
        #   The parent resource name, for example projects/my-project-id or
        #   organizations/my-org-id.
        # @param [Fixnum] page_size
        #   Optional size of the page, can be limited by server. If zero server returns
        #   a page of max size 100.
        # @param [String] page_token
        #   Optional page token to continue retrieval. Comes from previous call
        #   to `ListDeidentifyTemplates`.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListDeidentifyTemplatesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListDeidentifyTemplatesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_project_deidentify_templates(parent, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v2beta2/{+parent}/deidentifyTemplates', options)
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListDeidentifyTemplatesResponse::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListDeidentifyTemplatesResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates the inspect template.
        # @param [String] name
        #   Resource name of organization and deidentify template to be updated, for
        #   example `organizations/433245324/deidentifyTemplates/432452342`.
        # @param [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2UpdateDeidentifyTemplateRequest] google_privacy_dlp_v2beta2_update_deidentify_template_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_project_deidentify_template(name, google_privacy_dlp_v2beta2_update_deidentify_template_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:patch, 'v2beta2/{+name}', options)
          command.request_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2UpdateDeidentifyTemplateRequest::Representation
          command.request_object = google_privacy_dlp_v2beta2_update_deidentify_template_request_object
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DeidentifyTemplate
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Starts asynchronous cancellation on a long-running DlpJob.  The server
        # makes a best effort to cancel the DlpJob, but success is not
        # guaranteed.
        # @param [String] name
        #   The name of the DlpJob resource to be cancelled.
        # @param [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2CancelDlpJobRequest] google_privacy_dlp_v2beta2_cancel_dlp_job_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GoogleProtobufEmpty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GoogleProtobufEmpty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def cancel_project_dlp_job(name, google_privacy_dlp_v2beta2_cancel_dlp_job_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v2beta2/{+name}:cancel', options)
          command.request_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2CancelDlpJobRequest::Representation
          command.request_object = google_privacy_dlp_v2beta2_cancel_dlp_job_request_object
          command.response_representation = Google::Apis::DlpV2beta2::GoogleProtobufEmpty::Representation
          command.response_class = Google::Apis::DlpV2beta2::GoogleProtobufEmpty
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes a long-running DlpJob. This method indicates that the client is
        # no longer interested in the DlpJob result. The job will be cancelled if
        # possible.
        # @param [String] name
        #   The name of the DlpJob resource to be deleted.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GoogleProtobufEmpty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GoogleProtobufEmpty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_project_dlp_job(name, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:delete, 'v2beta2/{+name}', options)
          command.response_representation = Google::Apis::DlpV2beta2::GoogleProtobufEmpty::Representation
          command.response_class = Google::Apis::DlpV2beta2::GoogleProtobufEmpty
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the latest state of a long-running DlpJob.
        # @param [String] name
        #   The name of the DlpJob resource.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DlpJob] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DlpJob]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_dlp_job(name, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v2beta2/{+name}', options)
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DlpJob::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2DlpJob
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists DlpJobs that match the specified filter in the request.
        # @param [String] parent
        #   The parent resource name, for example projects/my-project-id.
        # @param [String] filter
        #   Optional. Allows filtering.
        #   Supported syntax:
        #   * Filter expressions are made up of one or more restrictions.
        #   * Restrictions can be combined by `AND` or `OR` logical operators. A
        #   sequence of restrictions implicitly uses `AND`.
        #   * A restriction has the form of `<field> <operator> <value>`.
        #   * Supported fields/values for inspect jobs:
        #   - `state` - PENDING|RUNNING|CANCELED|FINISHED|FAILED
        #   - `inspected_storage` - DATASTORE|CLOUD_STORAGE|BIGQUERY
        #   * Supported fields for risk analysis jobs:
        #   - `state` - RUNNING|CANCELED|FINISHED|FAILED
        #   * The operator must be `=` or `!=`.
        #   Examples:
        #   * inspected_storage = cloud_storage AND state = done
        #   * inspected_storage = cloud_storage OR inspected_storage = bigquery
        #   * inspected_storage = cloud_storage AND (state = done OR state = canceled)
        #   The length of this field should be no more than 500 characters.
        # @param [Fixnum] page_size
        #   The standard list page size.
        # @param [String] page_token
        #   The standard list page token.
        # @param [String] type
        #   The type of job. Defaults to `DlpJobType.INSPECT`
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListDlpJobsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListDlpJobsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_project_dlp_jobs(parent, filter: nil, page_size: nil, page_token: nil, type: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v2beta2/{+parent}/dlpJobs', options)
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListDlpJobsResponse::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListDlpJobsResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['filter'] = filter unless filter.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['type'] = type unless type.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Redacts potentially sensitive info from an image.
        # This method has limits on input size, processing time, and output size.
        # [How-to guide](/dlp/docs/redacting-sensitive-data-images)
        # @param [String] parent
        #   The parent resource name, for example projects/my-project-id.
        # @param [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2RedactImageRequest] google_privacy_dlp_v2beta2_redact_image_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2RedactImageResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2RedactImageResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def redact_project_image(parent, google_privacy_dlp_v2beta2_redact_image_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v2beta2/{+parent}/image:redact', options)
          command.request_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2RedactImageRequest::Representation
          command.request_object = google_privacy_dlp_v2beta2_redact_image_request_object
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2RedactImageResponse::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2RedactImageResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Creates an inspect template for re-using frequently used configuration
        # for inspecting content, images, and storage.
        # @param [String] parent
        #   The parent resource name, for example projects/my-project-id or
        #   organizations/my-org-id.
        # @param [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2CreateInspectTemplateRequest] google_privacy_dlp_v2beta2_create_inspect_template_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_project_inspect_template(parent, google_privacy_dlp_v2beta2_create_inspect_template_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:post, 'v2beta2/{+parent}/inspectTemplates', options)
          command.request_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2CreateInspectTemplateRequest::Representation
          command.request_object = google_privacy_dlp_v2beta2_create_inspect_template_request_object
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Deletes inspect templates.
        # @param [String] name
        #   Resource name of the organization and inspectTemplate to be deleted, for
        #   example `organizations/433245324/inspectTemplates/432452342`.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GoogleProtobufEmpty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GoogleProtobufEmpty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_project_inspect_template(name, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:delete, 'v2beta2/{+name}', options)
          command.response_representation = Google::Apis::DlpV2beta2::GoogleProtobufEmpty::Representation
          command.response_class = Google::Apis::DlpV2beta2::GoogleProtobufEmpty
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets an inspect template.
        # @param [String] name
        #   Resource name of the organization and inspectTemplate to be read, for
        #   example `organizations/433245324/inspectTemplates/432452342`.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_inspect_template(name, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v2beta2/{+name}', options)
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists inspect templates.
        # @param [String] parent
        #   The parent resource name, for example projects/my-project-id or
        #   organizations/my-org-id.
        # @param [Fixnum] page_size
        #   Optional size of the page, can be limited by server. If zero server returns
        #   a page of max size 100.
        # @param [String] page_token
        #   Optional page token to continue retrieval. Comes from previous call
        #   to `ListInspectTemplates`.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListInspectTemplatesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListInspectTemplatesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_project_inspect_templates(parent, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:get, 'v2beta2/{+parent}/inspectTemplates', options)
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListInspectTemplatesResponse::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2ListInspectTemplatesResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates the inspect template.
        # @param [String] name
        #   Resource name of organization and inspectTemplate to be updated, for
        #   example `organizations/433245324/inspectTemplates/432452342`.
        # @param [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2UpdateInspectTemplateRequest] google_privacy_dlp_v2beta2_update_inspect_template_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_project_inspect_template(name, google_privacy_dlp_v2beta2_update_inspect_template_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command =  make_simple_command(:patch, 'v2beta2/{+name}', options)
          command.request_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2UpdateInspectTemplateRequest::Representation
          command.request_object = google_privacy_dlp_v2beta2_update_inspect_template_request_object
          command.response_representation = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate::Representation
          command.response_class = Google::Apis::DlpV2beta2::GooglePrivacyDlpV2beta2InspectTemplate
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end

        protected

        def apply_command_defaults(command)
          command.query['key'] = key unless key.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
        end
      end
    end
  end
end
