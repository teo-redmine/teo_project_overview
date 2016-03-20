# Coding: UTF-8

Redmine::Plugin.register :teo_subprojects_tree do
  name 'Teo Subprojects Tree plugin'
  author 'Junta de Andalucía'
  description 'Renders the project list as a collapsable jQuery fancytree'
  version '0.0.1'
  url 'https://github.com/chibacityblues/redmine_projects_tree'
  author_url 'http://www.juntadeandalucia.es'
end

require 'teo_subprojects_tree'
require_dependency 'teo_subprojects_tree_hook_listener'
ProjectsHelper.send(:include, TeoSubprojectsTree)
