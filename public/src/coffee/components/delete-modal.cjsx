Fluxxor       = require 'fluxxor'
jade          = require 'react-jade'
Radium        = require 'radium'
_             = require 'lodash'
Modal         = require 'react-modal'
modalStyles   = require './styles/modal'
deleteOkStyle = require './styles/delete-ok-button'
SmallButton   = require './small-button'

FluxMixin       = Fluxxor.FluxMixin React

DeleteModal = React.createClass
  mixins : [
    FluxMixin
  ]

  closeDeleteModal : ->
    @getFlux().actions.article.closeDeleteModal()

  handleDeleteOkClick : ->
    @getFlux().actions.article.deleteArticle @props.deleteId

  handleDeleteCancelClick : ->
    @getFlux().actions.article.closeDeleteModal()

  render : ->
    jade.compile("""
      Modal(
        isOpen=isDeleteModalOpen
        onRequestClose=closeDeleteModal
        style=modalStyles)
        span delete this post, really ok?
        br
        SmallButton(
          buttonText="Ok"
          handleClick=handleDeleteOkClick
          buttonStyle=deleteOkStyle
        )
        SmallButton(
          buttonText="Cancel"
          handleClick=handleDeleteCancelClick
          buttonStyle=deleteOkStyle
        )

    """)(_.assign {}, @, @props)

module.exports = Radium DeleteModal
