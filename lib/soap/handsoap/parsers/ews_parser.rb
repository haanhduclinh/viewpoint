#############################################################################
# Copyright © 2010 Dan Wanek <dan.wanek@gmail.com>
#
#
# This file is part of Viewpoint.
#
# Viewpoint is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
#
# Viewpoint is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with Viewpoint.  If not, see <http://www.gnu.org/licenses/>.
#############################################################################
module Viewpoint
  module EWS
    module SOAP
      class EwsParser
        include Parser

        # Parsing Methods
        # ---------------

        def resolve_names_response(opts)
        end
        def expand_dl_response(opts)
        end


        def find_folder_response(opts)
          folders = []
          (resp/'//m:RootFolder/t:Folders/t:Folder').each do |f|
            parms = {}
            parms[:id] = (f/('t:FolderId')).first['Id']
            parms[:parent_id] = (f/('t:ParentFolderId')).first['Id']
            parms[:disp_name] = (f/('t:DisplayName')).first.to_s
            folders << parms
          end
          folders
        end


        def find_item_response(opts)
        end
        def get_folder_response(opts)
        end
        def convert_id_response(opts)
        end
        def create_folder_response(opts)
        end
        def delete_folder_response(opts)
        end
        def update_folder_response(opts)
        end
        def move_folder_response(opts)
        end
        def copy_folder_response(opts)
        end
        def subscribe_response(opts)
        end

        # @todo Better handle error messages
        #   Like a response object with methods
        #   #success? (boolean)
        #   #message (String) text message
        def unsubscribe_response(opts)
          rclass = (@response/'//m:UnsubscribeResponseMessage').first['ResponseClass']
          if rclass == 'Success'
            return true
          else
            warn  (@response/'//m:MessageText').first.to_s
            return false
          end
        end

        def get_events_response(opts)
        end
        def sync_folder_hierarchy_response(opts)
        end
        def sync_folder_items_response(opts)
        end
        def get_item_response(opts)
        end
        def create_item_response(opts)
        end
        def delete_item_response(opts)
        end
        def update_item_response(opts)
        end
        def send_item_response(opts)
        end
        def move_item_response(opts)
        end
        def copy_item_response(opts)
        end
        def create_attachment_response(opts)
        end
        def delete_attachment_response(opts)
        end
        def get_attachment_response(opts)
        end
        def create_managed_folder_response(opts)
        end
        def get_delegate_response(opts)
        end
        def add_delegate_response(opts)
        end
        def remove_delegate_response(opts)
        end
        def update_delegate_response(opts)
        end
        def get_user_availability_response(opts)
        end
        def get_user_oof_settings_response(opts)
        end
        def set_user_oof_settings_response(opts)
        end

      end # EwsParser
    end # SOAP
  end # EWS
end # Viewpoint