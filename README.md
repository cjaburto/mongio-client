# mongio-client

client wrapper for [promised-mongo](https://github.com/gordonmleigh/promised-mongo), and [socket.io](https://github.com/Automattic/socket.io).

## Install 

add [q](https://github.com/kriskowal/q) for the promises thing and mongio to your html or coffee whatever ...

	script : 'path/to/q.js'
	script : 'path/to/mongio.js'

## How To.
You can use it with [mongio](https://github.com/cjaburto/mongio) the server version, or write the backend yourself.
the pattern its the same that promised mongo use(love that!).
If you set socket.io do it globally if you dont then dont bother mongio will setup and of course you still can used.

### Save
you can pass a verify : true, this will validate if the collection exist, the res var will be equal to 'exist' or 'ok'
	db.save({name:'cool name'},verify:true).then (res)-> 
		if res is 'exist then blablabla
		if res is 'ok' then blablab
	,(err)->
		your awsm err handler!

 


