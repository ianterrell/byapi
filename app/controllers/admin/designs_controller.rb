class Admin::DesignsController < Admin::BaseController
  inherit_resources
  belongs_to :site
end
