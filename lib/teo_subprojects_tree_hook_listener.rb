class TeoSubprojectsTreeHookListener < Redmine::Hook::ViewListener
  render_on :view_projects_show_right_teo, :partial => "projects/subtree"

  def view_projects_show_left_teo(context = {})
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
      return content_tag("p", l(:create_wiki_message))
    end
  end
end
