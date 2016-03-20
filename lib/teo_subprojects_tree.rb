module TeoSubprojectsTree
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods

    def render_subproject_hierarchy(project)
      projects = Project.visible.where("lft > ? AND rgt <= ?",project.lft,project.rgt).sort_by(&:lft)
      render_project_hierarchy(projects)
    end

    def render_project_hierarchy(projects)
      render_project_nested_lists(projects) do |project|
        s = link_to_project(project, {}, :class => "#{project.css_classes} #{User.current.member_of?(project) ? 'my-project' : nil}")
        if project.description.present?
          s << content_tag('div', textilizable(project.short_description, :project => project), :class => 'wiki description')
        end
        s
      end
    end


    # Renders a tree of projects as a nested set of unordered lists
    # The given collection may be a subset of the whole project tree
    # (eg. some intermediate nodes are private and can not be seen)
    def render_project_nested_lists(projects)
      s = ''
      if projects.any?
        ancestors = []
        original_project = @project
        projects.sort_by(&:lft).each do |project|
          # set the project environment to please macros.
          @project = project
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
          #classes = (ancestors.empty? ? 'root folder expanded' : 'child')
          classes = (ancestors.empty? ? 'root folder ' : 'child')
          s << "<li class='#{classes}'><div class='#{classes}'>"
          #s << h(block_given? ? yield(project) : project.name)
          #s << link_to_project(project, {:only_path => false}, :class => "project") 
          #s << link_to("#{project.name}", :controller => projects, :title => "#{project.id}", :only_path => false}, :class => "project")
          s << link_to( "#{project.name}", project_path(project), :class => "project", :title => "Redmine ID: #{project.id}") 
          s << "</div>\n"
          ancestors << project
        end
        s << ("</li></ul>\n" * ancestors.size)
        @project = original_project
      end
      s.html_safe
    end

  end
end
