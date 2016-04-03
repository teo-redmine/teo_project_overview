# Coding: UTF-8

Redmine::Plugin.register :teo_project_overview do
  name 'Teo Project Overview plugin'
  author 'Junta de Andalucía'
  description 'Replaces project overview pages'
  version '0.0.1'
  url 'https://github.com/chibacityblues/redmine_projects_tree'
  author_url 'http://www.juntadeandalucia.es'
end

require 'teo_project_overview'
ProjectsHelper.send(:include, TeoProjectOverview)
