class TeoSubprojectsTreeHookListener < Redmine::Hook::ViewListener
  render_on :view_projects_show_right, :partial => "projects/subtree"
#  render_on :view_projects_show_left, :partial => "wiki/content"
end

