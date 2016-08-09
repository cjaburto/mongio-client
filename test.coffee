db.use 'escalamientos'
  .then (res)-> console.log res

test = db.collection 'test'

test.count().then (c)->
  console.log c
,(err)->
  console.log err

#test.stats().then (s)->
#  console.log s
#,(err)->
#  console.log err

#db.stats().then (stat)->
#  console.log stat

#test.update({_id : '57a90e0d8f065c0a3540fcfe'},
#  {
#    client : 'test'
#    relación : ['testrel']
#    correos : [{email:'test@netprovider.cl',status:'false'}]
#    cc:[]
#    bcc:[]
#    mid:0
#  })
#.then (r)->
#  console.log r
#,(err)->
#  console.log err

#test.save
#  client : 'test'
#  relación : ['testrel']
#  correos : [{email:'test@netprovider.cl',status:true}]
#  cc:[]
#  bcc:[]
#  mid:0
#.then (r)->
#  console.log r

#test.find().limit(10).done()
#  .then (x)->
#    console.log x
#    return x
#  .then (x)->
#    console.log x[0]
#    return x
#  .then (x)->
#    console.log x[1]

#test.findOne _id : '577e73e71582829958c8e1c5'
#  .then (docs)->
#    console.log docs
#  ,(err)->
#    console.log err
#test.remove({_id:'576d5c18b4516932738de2c9'}).then (r)->
#  console.log r
#, (err)->
#  console.log err

ptest = new Promise (resolve , reject)->
  resolve 1

ptest.then (x)->
  console.log x
  return x + 2
.then (x)->
  console.log x

t2 = (x)->
  new Promise (resolve , reject)->
    resolve x

t2(4).then (x)->
  console.log x
  return x + 10
.then (x)->
  console.log x

