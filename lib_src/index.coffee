Module = require('module')
pathUtil = require('path')
fs = require('fs')

parseName = (folder, file) ->
  extname = pathUtil.extname file
  name = pathUtil.basename file, extname
  fullpath = pathUtil.join(folder, file)

  {fullpath, name, extname}

createFileProperty = (instance, name, path) ->
  Object.defineProperty instance, name,
    get: ->
      require(path)

createDirProperty = (instance, name, path) ->
  Object.defineProperty instance, name, 
    get: ->
      new LazyLoader(path)

class LazyLoader
  constructor: (@__rootPath) ->
    files = fs.readdirSync(@__rootPath)
    
    for file in files      
      {fullpath, name, extname} = parseName(@__rootPath, file)

      stat = fs.lstatSync(fullpath)

      if stat.isFile() 
        createFileProperty(this, name, fullpath) if Module._extensions[extname]?  
      else if stat.isDirectory()
        createDirProperty(this, name, fullpath)
        
createLoader = LazyLoader.create  = (rootPath) ->
  new LazyLoader(rootPath)

exports = module.exports = createLoader
exports.LazyLoader = LazyLoader
