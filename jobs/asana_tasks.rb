#!/usr/bin/env ruby
require 'asana'
require 'json'

# You need to enter your token to query Asana.
# You can find that by clicking on your name in the bottom right and selecting Account Settings.
# Click on the Apps tab.
token = 'ASANA TOKEN'
# The name of the workspace you would like to query
workspace_name = 'WORKSPACE NAME'
# Number of tasks to show
num_tasks = 20

client = Asana::Client.new do |c|
  c.authentication :access_token, token
end

# get workspace id
workspace_id = nil
workspaces = client.workspaces.find_all
workspaces.each do |workspace|
	if workspace.name == workspace_name
		workspace_id = workspace.id
	end
end

# set workspace
workspace = client.workspaces.find_by_id(workspace_id)

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '30m', :first_in => 0 do |job|
	list = Array.new
	tasks = client.tasks.find_all(:assignee => :me, :workspace => workspace_id, :completed_since => Time.now.utc.iso8601) # get incomplete tasks

	i = 0
	tasks.each do |task|
		puts task.id
		task_detail = Asana::Task.find_by_id(client, task.id)
		if task_detail.assignee_status == 'today'
			if task_detail.completed != true
				icon = 'icon-check-empty'
				list.push({label: task.name, icon: icon})
				i += 1
			end
		end
		break if i == num_tasks
	end

	send_event('asana_tasks', {items: list})
end
