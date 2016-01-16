Description
===========

A [Dashing](https://github.com/Shopify/dashing) widget for displaying tasks assigned to you in Asana.

(Originally at https://gist.github.com/willjohnson/6334811 but moved to better track changes.)

![](http://i.imgur.com/bIlT5xS.png)

Dependencies
============

You need an account with [Asana](http://www.asana.com) to use this.

Add to dashing's gemfile:
```
gem 'asana'
gem 'json'
```
and run `bundle install`.

Usage
============

Add the widget HTML to your dashboard
```
    <li data-row="1" data-col="1" data-sizex="1" data-sizey="2">
      <div data-id="asana_tasks" data-view="AsanaTasks" data-title="Today's Tasks"></div>
    </li>
```
Create a directory titled "asana_tasks" under your widgets directory and move asana_tasks.coffee, asana_tasks.html, and asana_tasks.scss into that directory.

Get your token from Asana by logging into asana.com, clicking on your name in the bottom right, and selecting account settings.

You also need the name of the workspace that you want to show tasks from.

Modify the api_key and workspace_name variables of the asana_tasks.rb file.

Move asana_tasks.rb into your jobs folder.
