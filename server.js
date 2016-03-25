var exec = require('child_process').exec;
var fs = require("fs");

var Twit = require('twit')

var T = new Twit({
  consumer_key:         process.env.CONSUMER_KEY,
  consumer_secret:      process.env.CONSUMER_SECRET,
  access_token:         process.env.ACCESS_TOKEN,
  access_token_secret:  process.env.ACCESS_TOKEN_SECRET,
  timeout_ms:           60*1000,  // optional HTTP request timeout to apply to all requests.
});


exec("processing-java --sketch=`pwd`/render --run", function (error, stdout, stderr) {
  var b64content = fs.readFileSync('./render/render.png', { encoding: 'base64' })

// first we must post the media to Twitter
T.post('media/upload', { media_data: b64content }, function (err, data, response) {

  // now we can reference the media and post a tweet (media will attach to the tweet)
  var mediaIdStr = data.media_id_string
  var params = { status: 'Sacred Geometry #sacredgeometry #generative #art #processing', media_ids: [mediaIdStr] }

  T.post('statuses/update', params, function (err, data, response) {
    console.log(data)
  })
})


  // // TODO: tweet now
  // var filePath = '/render/render.png'
  // T.postMediaChunked({ file_path: filePath }, function (err, data, response) {
  //   console.log(data)
  // });

  // T.post('statuses/update', { status: 'Hello World!' }, function(err, data, response) {
  //   console.log(data)
  //
  // })




})
