if window.socket is undefined or window.socket is '' or window.socket is null
  socket = io()
else
  socket = window.socket

class DB
  connect : (rdb)->
    console.log rdb
    new Promise (resolve , reject)->
      socket.emit 'connectDb' , rdb,(obj)=>
        if obj.status is 'ok'   then resolve obj.res
        if obj.status is 'err'  then reject obj.err
    #deferred = Q.defer()
    #socket.emit 'connectDb',rdb,(obj)->
    #  if obj.status is 'ok'   then deferred.resolve obj.res
    #  if obj.status is 'err'  then deferred.reject new Error obj.err
    #return deferred.promise
  
  collection : (col)->
    find : (query)->
      vlimit : undefined
      vskip  : undefined
      vsort  : undefined
      vproy  : undefined

      limit : (limit)->
        @.vlimit = limit
        return @

      skip : (skip)->
        @.vskip = skip
        return @

      sort : (sort)->
        @.vsort = sort
        return @

      complete : (fn)->
        if query is undefined then query = {}
        if @.vsort is undefined then @.vsort = _id : -1
        gen = 
          collection  : col
          query       : query
          skip        : @.vskip
          limit       : @.vlimit
          sort        : @.vsort
          proyection  : @.vproy

        socket.emit 'find', gen ,(obj)-> fn obj
        return @

    remove : (query)->
      deferred = Q.defer()
      data =
        collection  : col
        query       : query
      socket.emit 'remove' , data ,(obj)->
        if obj.status is 'ok'  then deferred.resolve obj.res
        if obj.status is 'err' then deferred.reject new Error obj.err
      return deferred.promise

    findOne : (query)->
      deferred = Q.defer()
      data =
        collection  : col
        query       : query
      socket.emit 'findOne' , data ,(obj)->
        if obj.status is 'ok'     then deferred.resolve obj.res
        if obj.status is '!exist' then deferred.reject new Error '!exist'
        if obj.status is 'err'    then deferred.reject new Error obj.err
      return deferred.promise

    save : (query,verify)->
      deferred = Q.defer()

      if verify is undefined then verify = false

      gen = 
        collection : col
        query      : query
        verify     : verify.verify

      socket.emit 'save' , gen ,(obj)->
        switch obj.status
          when 'ok'    then deferred.resolve obj.res
          when 'exist' then deferred.resolve 'exist'
          when 'err'   then deferred.reject new Error obj.err
      return deferred.promise

    update : (query,update,options)->
      deferred = Q.defer()
      gen = 
        collection : col
        query : query
        update : update
        options : options
      socket.emit 'update', gen ,(obj)->
        switch obj.status
          when 'ok'  then deferred.resolve obj.res
          when 'err' then deferred.reject new Error obj.err
      return deferred.promise

    password : (set)->
      deferred = Q.defer()
      data =
        collection  : col
        user        : set.user
        newPass     : set.newPass
        oldPass     : set.oldPass
      socket.emit 'changePass' , data ,(obj)->
        switch res.status
          when 'ok'     then deferred.resolve obj.res
          when '!match' then deferred.resolve '!match'
          when 'err'    then deferred.reject new Error obj.err
      return deferred.promise

    drop : ->
      deferred = Q.defer()
      socket.emit 'drop',col,(obj)->
        if obj.status is 'ok'  then deferred.resolve obj.res
        if obj.status is 'err' then deferred.reject new Error obj.err
      return deferred.promise
  
  chkpasswd : (query)->
    deferred = Q.defer()
    options =
      query : query
    socket.emit 'chkpasswd' , options , (obj)->
      console.log obj
      switch obj.status
        when 'ok'     then deferred.resolve obj.res
        when '!match' then deferred.resolve '!match'
        when 'err'    then deferred.reject new Error obj.err
    return deferred.promise

  mongoimport :(file)->
    deferred = Q.defer()
    socket.emit 'mongoimport',file,(obj)->
      if obj.status is 'ok'     then deferred.resolve obj.res
      if obj.status is 'stderr' then deferred.reject new Error obj.err
      if obj.status is 'err'    then deferred.reject new Error obj.err
    return deferred.promise

window.db = new DB()
