# mongio-client
client wrapper for promised-mongo and socket.io
## Install

add [q](https://github.com/kriskowal/q) for the promises thing and mongio to your html or coffee whatever ...

        script : 'path/to/q.js'
        script : 'path/to/mongio.js'

## How To.
You can use it with [mongio](https://github.com/cjaburto/mongio) the server version, or write the backend yourself.
the pattern its the same that promised mongo use(love that!).
If you set socket.io do it globally if you dont then dont bother mongio will setup and of course you still can used.


### Save
you can pass a verify : true, this will validate if the collection exist, the res var will be equal to 'exist' or 'ok'.

``` coffee
db.collection('your collection').save({name:'cool name'},verify:true).then (res)->
  if res is 'exist then blablabla
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
