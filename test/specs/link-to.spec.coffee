describe 'angular-linkto.linkTo', ->

  linkTo = null

  beforeEach module 'angular-linkto'

  beforeEach inject ($filter)->
    linkTo = $filter('linkTo')

  it 'injects', ->
    linkTo.should.be.defined

  it 'returns a string', ->
    (typeof linkTo('asdf')).should.eql 'string'

  it 'passes route string through without params', ->
    r = '/route/to/something'
    linkTo(r).should.eql r

  it 'requires a route', ->
    (-> linkTo()).should.throw()

  it 'puts named param after colon if supplied', ->
    linkTo('/people/:id', { id: 123 }).should.eql '/people/123'

  it 'throws error if named param in middle of url cannot be filled', ->
    (-> linkTo('/people/:id/stuff', { something: 'else' })).should.throw()

  it 'throws error if named param in middle has key but no value', ->
    (-> linkTo('/people/:id/stuff', { stuff: undefined })).should.throw()

  it 'removes everything after last slash if named param at END cannot be filled', ->
    linkTo('/people/:id', {}).should.eql '/people'

  it 'fills all named params', ->
    linkTo('/people/:id/stuff/:more', { id: 123, more: 'goodies' }).should.eql '/people/123/stuff/goodies'
#
#  # TODO: handle this circular dependency
#  describe 'With Models', ->
#
#    TestModel = null
#
#    beforeEach inject (Module, AttributesMixin) ->
#      class TestModel extends Module
#        @include AttributesMixin
#
#        constructor: ->
#          @attributes = {}
#
#    it 'handles a model with attributes', ->
#      model = new TestModel
#      model.set
#        id: 123
#      linkTo('/x/posts/:id', model).should.eql "/x/posts/#{model.get('id')}"