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

  describe 'With protocols', ->

    it 'ignores http://', ->
      linkTo('http://google.com').should.eql 'http://google.com'

    it 'ignores https://', ->
      linkTo('https://google.com').should.eql 'https://google.com'

    it 'ignores ftp://', ->
      linkTo('ftp://google.com').should.eql 'ftp://google.com'

    it 'ignores protocol and can remove trailing named param', ->
      linkTo('ftp://google.com/something/:else').should.eql 'ftp://google.com/something'

    it 'ignores protocol and can fill named params', ->
      linkTo('ftp://google.com/something/:else', { else: 'forthwith' }).should.eql 'ftp://google.com/something/forthwith'

    it 'throws error if unfilled param in middle of url', ->
      (-> linkTo('ftp://google.com/:before/something')).should.throw()