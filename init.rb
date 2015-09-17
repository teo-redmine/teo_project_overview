# Coding: UTF-8

Redmine::Plugin.register :redmine_projects_tree do
  name 'Redmine Projects Tree plugin'
  author 'Oliver Loesch'
  description 'Renders the project list as a collapsable jQuery fancytree'
  version '0.5.0'
  url 'https://github.com/chibacityblues/redmine_projects_tree'
  author_url 'https://github.com/chibacityblues'
end

require 'redmine_projects_tree'
ProjectsHelper.send(:include, ProjectsTree)
