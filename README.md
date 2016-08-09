# mongio-client
client wrapper for promised-mongo and socket.io
## Install

        script : '/socket.io/socket.io.js'
        script : 'path/to/mongio.js'

## How To.
You can use it with [mongio](https://github.com/cjaburto/mongio) the server version, or write the backend yourself.
the pattern its the same that promised mongo(love that!).
If you set socket.io do it globally if you dont, then dont bother mongio will do it.

##Use
``` coffee
if a is 'x' then db.use 'somedb'
if a is 'y' then db.use 'otherdb'
```

``` coffee
db.use('some db')
```

``` coffee
db.use('somedb').then (status)->
  console.log status
,(err)->
        ...
```
##Collection
```coffee
db.collection('mycollection').update ...
```
```coffee
users = db.collection 'users'
users.find()...
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
db.collection('collection name').find().done().then (obj)->
  console.log obj
  return obj
.then (obj)->
  console.log obj[0]
  return obj
.then (obj)->
  console.log obj[9]
```

or

```
db.collection('...').find().limit(10).skip(0).sort({_id:-1}).done().then (obj)->
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


### Count
``` coffee
db.collection('x').count(query).then (r)->
  ...
,(err)->
  ...
```

### Collection Stats
``` coffee
db.collection(x).stats().then(s)-> ...

```

### Db Stats

``` coffee
db.stats().then (s)->
  console.log s
,(err)->
  console.log err
```

## Extra.

### checkPass
it may be useful ...
``` coffee
db.chkpasswd({ukey:'unencrypted key' , ekey:'encrypted key'}).then (res)->
  ...
,(err)->
  ...
```
