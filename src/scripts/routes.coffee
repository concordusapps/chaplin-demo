'use strict'

module.exports = (match) ->
  match '', 'index#show'
  match 'about', 'info#about'
  match 'getting-started', 'info#started'
