class TeoSubprojectsTreeHookListener < Redmine::Hook::ViewListener
  render_on :view_projects_show_right, :partial => "projects/subtree"
  #render_on :view_projects_show_left, :partial => "wiki/content", :locals => {:content => Project.find('si').wiki.find_page(nil).content_for_version(nil)}
  def view_projects_show_left(context = {})
    wiki = Project.find(context[:project]).wiki
    page = wiki.find_page(nil) if wiki
    content = page.content_for_version(nil) if page
    if content
      context[:content] = content
      return context[:controller].send(:render_to_string, {
          :partial => 'wiki/content',
          :locals => context
      })
    else
      return content_tag("p", "Cree una wiki de proyecto para que aparezca aquí.")
    end
  end
end

