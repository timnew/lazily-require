require('./spec_helper')

path = require('path')
lazy = require('../index')
LazyLoader = lazy.LazyLoader

describe 'LazyLoader', ->
  Fixtures  = lazy path.join(__dirname, 'fixtures')

  it 'should create fixtures', ->
    expect(Fixtures).to.be.an.instanceOf LazyLoader 

  it 'should require javascript', ->
    Fixtures.should.have.ownProperty 'javascript'    
    Fixtures.javascript.name.should.equal 'JavaScript'

  it 'should require coffeescript', ->
    Fixtures.should.have.ownProperty 'coffeescript'    
    Fixtures.coffeescript.name.should.equal 'CoffeeScript'

  it 'should ignore unsupported files', ->
    Fixtures.should.not.have.ownProperty 'other'

  it 'should load lazily', ->
    Fixtures.require_counter.get('lazy_test').should.equal 0
    Fixtures.lazy_test
    Fixtures.require_counter.get('lazy_test').should.equal 1
    Fixtures.lazy_test
    Fixtures.require_counter.get('lazy_test').should.equal 1

  it 'should require folder', ->
    Fixtures.should.have.ownProperty 'folder'        
    Fixtures.folder.should.be.an.instanceOf LazyLoader

    Fixtures.folder.should.have.ownProperty 'nested'
    Fixtures.folder.nested.should.equal 'Nested JavaScript'    
