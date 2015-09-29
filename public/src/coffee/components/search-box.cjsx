Fluxxor        = require 'fluxxor'
jade           = require 'react-jade'
_              = require 'lodash'
Radium         = require 'radium'
searchBoxStyle = require './styles/search-box'

FluxMixin = Fluxxor.FluxMixin React

SearchBox = React.createClass
  mixins : [FluxMixin]

  enterSearchWord : (e) ->
    @getFlux().actions.searchBox.search e.target.value

  render : ->
    jade.compile("""
      input(placeholder="search" onChange=enterSearchWord style=searchBoxStyle.search)
    """)(_.assign {}, @, @props)

module.exports = Radium SearchBox
