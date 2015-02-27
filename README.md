# mongio-client
client wrapper for promised-mongo and socket.io
## Install

add [q](https://github.com/kriskowal/q) for the promises thing and mongio to your html or coffee whatever ...

        script : 'path/to/q.js'
        script : 'path/to/mongio.js'

## How To.
You can use it with [mongio](https://github.com/cjaburto/mongio) the server version, or write the backend yourself.
the pattern its the same that promised mongo use(love that!).
If you set socket.io do it globally if you dont then dont bother mongio will setup and of course you still can use it.


### Save
you can pass a verify : true, this will validate if the doc exist, the res var will be equal to 'exist' or 'ok'.

``` coffee
db.collection('your collection').save({name:'cool name'},verify:true).then (res)->
  if res is 'exist' then blablabla
  if res is 'ok' then blablab
,(err)->
  your awsm err handler!
```

### Update
just like mongo you pass the query and the update

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
if you want all the docs just pass find(), otherwise ...

``` coffee
db.collection('collection name').find({},{},limit:5,skip:0).then (docs)->
        great stuff here!
,(err)->
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

### Login
the method use [bcrypt-nodejs](https://www.npmjs.com/package/bcrypt-nodejs) for the moment.
``` coffee
db.collection().login({user:'',pass:''}).then (status)->
        ...
,(err)->
        ...
```

### Connect
this it's usefull when you have to work with an slave db so you can switch connections, if you're are gonna use only your master db it's not really necesary.

``` coffee
db.collection('users').connect({db:'master'}).then (status)->
        ...
,(err)->
        ...
```
if you switch to an slave db then ...

``` coffee
 ...connect({db:'slave',user:'appuser',field:'the field where my db reference is stored'}).then (status)->
        ...
 ,(err)->
        ...
```

### MongoImport
pass a object with the name,path and type of the file.
``` coffee
file = name : whatever.csv, path : '/path/to/my/files', type: json/csv
db.mongoimport(file).then (status)->
        ...
,(err)->
        ...
```
