module ApplicationHelper

  def share_url user_id, resource_id, resource_class_name
    @share_url = ShareUrl.find_or_create_by_user_id_and_resource_id_and_resource_class_name(:user_id => user_id, :resource_id => resource_id, :resource_class_name => resource_class_name)
    
    @share_url.url
  end
  
  def clear
    '<div class="clear"></div>'.html_safe
  end
end
