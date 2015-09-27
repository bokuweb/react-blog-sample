Fluxxor            = require 'fluxxor'
jade               = require 'react-jade'
_                  = require 'lodash'
Radium             = require 'radium'

FluxMixin = Fluxxor.FluxMixin React

SearchBox = React.createClass
  mixins : [FluxMixin]

  enterSearchWord : (e) ->
    @getFlux().actions.searchBox.search e.target.value

  render : ->
    jade.compile("""
      div
        input(placeholder="search" value=search onChange=enterSearchWord)
    """)(_.assign {}, @, @props)

module.exports = Radium SearchBox
