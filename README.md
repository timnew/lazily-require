lazily-require [![NPM version][npm-image]][npm-url] [![Build Status][ci-image]][ci-url] [![Dependency Status][depstat-image]][depstat-url]
================

> Require node.js files from specific path. The file name is mapped to property name.
> The requirement happened lazily, the module won't be required until it is accessed.
> Could be useful in application, requirements can be simplified by using in conjunction with [approot](https://github.com/timnew/approot)

## Install

Install using [npm][npm-url].

    $ npm install lazily-require

## Usage

```javascript

var lazy = require('lazily-require');

var Models = lazy('./modules');

var User = Models.User;                   // equivalence to require('./modules/User')

var Credential = Models.admin.Credential; // equivalence to require('./modules/admin/Credential')

```

When used in conjunction of [approot](https://github.com/timnew/approot) to initialize the application environment.

```javascript
var lazy = require('lazily-require');

global.appRoot = require('approot')(__dirname).consolidate();

global.configuration = require(appRoot.config('configuration'));

global.Services = lazy appRoot.services();
global.Routes = lazy appRoot.routes();
global.Records = lazy appRoot.records();
global.Models = lazy appRoot.models();
global.Entities = lazy appRoot.entities();

// Reference as

var user = Models.User;
var user = new User();

var user2 = new Models.User();

app.get('/admin/login', Routers.admin.login.get);

```
   
## License
MIT

[![NPM downloads][npm-downloads]][npm-url]

[homepage]: https://github.com/timnew/lazily-require

[npm-url]: https://npmjs.org/package/lazily-require
[npm-image]: http://img.shields.io/npm/v/lazily-require.svg?style=flat
[npm-downloads]: http://img.shields.io/npm/dm/lazily-require.svg?style=flat

[ci-url]: https://drone.io/github.com/timnew/lazily-require/latest
[ci-image]: https://drone.io/github.com/timnew/lazily-require/status.png

[depstat-url]: https://gemnasium.com/timnew/lazily-require
[depstat-image]: http://img.shields.io/gemnasium/timnew/lazily-require.svg?style=flat
