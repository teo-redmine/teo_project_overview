module TeoProjectOverview
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def render_wiki(project)
      wiki = project.wiki
      page = wiki.find_page(nil) if wiki
      content = page.content_for_version(nil) if page
      if project.enabled_module(:wiki) && content
        context = {}
        context[:content] = content
        render :partial => 'wiki/content', :locals => context
      end
    end

    def render_subproject_hierarchy(project)
      projects = Project.visible.where("lft > ? AND rgt <= ?",project.lft,project.rgt).sort_by(&:lft)
      s = ''
      if projects.any?
        ancestors = []
        projects.sort_by(&:lft).each do |project|
          if (ancestors.empty? || project.is_descendant_of?(ancestors.last))
            s << "<ul class='projects #{ ancestors.empty? ? 'root' : nil}'>\n"
          else
            ancestors.pop
            s << "</li>"
            while (ancestors.any? && !project.is_descendant_of?(ancestors.last))
              ancestors.pop
              s << "</ul></li>\n"
            end
          end
          classes = (ancestors.empty? ? 'root folder ' : 'child')
          s << "<li class='#{classes}'><div class='#{classes}'>"
          s << link_to( "#{project.name}", project_path(project), :class => "project", :title => "Redmine ID: #{project.id}")
          s << "</div>\n"
          ancestors << project
        end
        s << ("</li></ul>\n" * ancestors.size)
      end
      s.html_safe
    end

  end
end
