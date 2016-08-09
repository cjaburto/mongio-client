if window.socket is undefined or window.socket is '' or window.socket is null
  socket = io()
else
  socket = window.socket

class DB
  use : (rdb)->
    new Promise (resolve , reject)->
      socket.emit 'connectDb' , rdb,(obj)->
        if obj.status is 'ok'   then resolve obj.res
        if obj.status is 'err'  then reject obj.err
  
  collection : (col)->
    find : (query)->
      vlimit : undefined
      vskip  : undefined
      vsort  : undefined
      vproy  : undefined

      limit : (limit)->
        @vlimit = limit
        return @

      skip : (skip)->
        @vskip = skip
        return @

      sort : (sort)->
        @vsort = sort
        return @

      done : ->
        new Promise (resolve , reject)=>
          if query is undefined then query = {}
          if @vsort is undefined then @vsort = _id : -1
          gen =
            collection  : col
            query       : query
            skip        : @vskip
            limit       : @vlimit
            sort        : @vsort
          socket.emit 'find', gen ,(obj)->
            if obj.status is 'ok'   then resolve obj.res
            if obj.status is 'err'  then reject obj.err

    remove : (query)->
      new Promise (resolve , reject)->
        data =
          collection  : col
          query       : query
        socket.emit 'remove' , data ,(obj)->
          if obj.status is 'ok'  then resolve obj.res
          if obj.status is 'err' then reject obj.err

    findOne : (query)->
      new Promise (resolve , reject)->
        data =
          collection  : col
          query       : query
        socket.emit 'findOne' , data ,(obj)->
          if obj.status is 'ok'     then resolve obj.res
          if obj.status is '!exist' then reject '!exist'
          if obj.status is 'err'    then reject obj.err

    save : (query,verify)->
      new Promise (resolve , reject)->
        if verify is undefined then verify = false

        gen =
          collection : col
          query      : query
          verify     : verify.verify

        socket.emit 'save' , gen ,(obj)->
          switch obj.status
            when 'ok'    then resolve obj.res
            when 'exist' then resolve 'exist'
            when 'err'   then reject obj.err

    update : (query,update,options)->
      new Promise (resolve , reject)->
        gen =
          collection : col
          query : query
          update : update
          options : options
        socket.emit 'update', gen ,(obj)->
          switch obj.status
            when 'ok'  then resolve obj.res
            when 'err' then reject obj.err

    password : (set)->
      new Promise (resolve , reject)->
        data =
          collection  : col
          user        : set.user
          newPass     : set.newPass
          oldPass     : set.oldPass
        socket.emit 'changePass' , data ,(obj)->
          switch res.status
            when 'ok'     then  resolve obj.res
            when '!match' then  resolve '!match'
            when 'err'    then  reject  obj.err

    stats : ->
      new Promise (resolve , reject)->
        socket.emit 'colStats' , col , (obj)->
          if obj.status is 'ok'   then resolve obj.res
          if obj.status is 'err'  then reject obj.err

    count : (query)->
      new Promise (resolve , reject)->
        gen = {}
        gen.collection = col
        gen.query      = query
        socket.emit 'count' , gen , (obj)->
          if obj.status is 'ok'   then resolve  obj.res
          if obj.status is 'err'  then reject   obj.err

    drop : ->
      new Promise (resolve , reject)->
        socket.emit 'drop',col,(obj)->
          if obj.status is 'ok'  then resolve obj.res
          if obj.status is 'err' then reject  obj.err
  
  chkpasswd : (query)->
    new Promise (resolve , reject)->
      options =
        query : query
      socket.emit 'chkpasswd' , options , (obj)->
        switch obj.status
          when 'ok'     then  resolve obj.res
          when '!match' then  resolve '!match'
          when 'err'    then  reject  obj.err

  stats : ->
    new Promise (resolve , reject)->
      socket.emit 'dbStats' , (obj)->
        if obj.status is 'ok'   then resolve  obj.res
        if obj.status is 'err'  then reject   obj.err
  
  mongoimport : (file)->
    new Promise (resolve , reject)->
      socket.emit 'mongoimport',file,(obj)->
        if obj.status is 'ok'     then  resolve obj.res
        if obj.status is 'stderr' then  reject  obj.err
        if obj.status is 'err'    then  reject  obj.err

window.db = new DB()
