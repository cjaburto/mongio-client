# mongio-client
client wrapper for promised-mongo and socket.io
## Install

add [q](https://github.com/kriskowal/q) for the promises thing, mongio and of course socket.io to your html, coffee or whatever ...

        script : '/socket.io/socket.io.js'
        script : 'path/to/q.js'
        script : 'path/to/mongio.js'


## Re-Check : remove , find ,findOne, update, save ,chkpasswd

## How To.
You can use it with [mongio](https://github.com/cjaburto/mongio) the server version, or write the backend yourself.
the pattern its the same that promised mongo use it(love that!).
If you set socket.io do it globally if you dont then dont bother mongio will setup and of course you still can use it.

##Connect
``` coffee
if a is 'x' then db.connect 'somedb'
if a is 'y' then db.connect 'otherdb'
```

``` coffee
db.connect('some db')
```

``` coffee
db.connect('somedb').then (status)->
  console.log status
,(err)->
        ...
```

```coffee
collection = db.collection 'collection'
collection.find()...
```

### Save
you can set up a verify : true, this will validate if the doc exist, the res var will be equal to 'exist' or 'ok'.

``` coffee
db.collection('your collection').save({name:'cool name'},verify:true).then (res)->
  if res is 'exist' then blablabla
  if res is 'ok' then blablab
,(err)->
  your awsm err handler!
```

### Update
just like mongo you set up the query the update and the options

``` coffee
db.collection('').update(query,update,options)
```

``` coffee
db.collection('contacts').update({},{$pull:{contact:{name:'michael jordan'}}},{multi:true})
.then (r)->
  ...
,(err)->
  ...
```

``` coffee
db.collection('contacts').update({address:'...'},{$pull:{contact:{name:'remi lacroix'}}}).then (r)-> ...
```

``` coffee
db.collection('collection name').update({name:'paulette'},{$set:{name:'new name'}}).then (res)->
  etc...
```

### Find One
the doc , res or however you call it, will return 'ok' or '!exist'
``` coffee
db.collection('collection name').findOne({query...}).then (doc)->
        etc...
.(err)->
```

### Find
you can use it pretty much like in the mdb shell ...

``` coffee
db.collection('collection name').find().complete (obj)->
        if obj.status is 'ok' then ...
        if obj.status is 'err' then ...
```
or

```
db.collection('...').find().limit(10).skip(0).sort({_id:-1}).complete (obj)->
        ...
```

### Remove

``` coffee
db.collection('col name').remove({_id:'54456623d192d9b663648e08'}).then (res)->
        etc...
,(err)->
        console.log err
```
### Drop
``` coffee
db.collection('your collection').drop().then (res)->
        ...
,(err)->
        ...
 ```
 
## Extras.

 
### Password
setup the pass using [bcrypt-nodejs](https://www.npmjs.com/package/bcrypt-nodejs).
 
``` coffee
db.collection('collection name').password({user:'someone',newPass:'',oldPass:''}).then (status)->
        if status is 'ok' then ...
        if status is '!match' then ...
,(err)->
        ...
```

### checkPass
it may be useful ...
``` coffee
db.chkpasswd({ukey:'unencrypted key' , ekey:'encrypted key'}).then (res)->
  ...
,(err)->
  ...
```

### MongoImport
pass a object with the name,path and type of the file.
``` coffee
file = name : 'whatever.csv', path : '/path/to/my/file', type: 'json/csv'
db.mongoimport(file).then (status)->
        ...
,(err)->
        ...
```
