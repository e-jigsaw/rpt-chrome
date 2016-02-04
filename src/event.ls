fetch-image = ->
  {id-or-url} <- chrome.storage.sync.get \idOrUrl
  {images, is-lock} <- chrome.storage.local.get <[images isLock]>
  if is-lock
    return
  <- chrome.storage.local.set do
    is-lock: true
  fetch "http://rpt.jgs.me/b/#{id-or-url}"
    .then (res)-> res.text!
    .then (text)->
      if Array.is-array images
        next-images = images.concat [text]
      else
        next-images = []
      <- chrome.storage.local.set do
        images: next-images
        is-lock: false
      if next-images.length < 20
        fetch-image!
    .catch (err)->
      console.log err
      chrome.storage.set do
        is-lock: false

req, sender, send <- chrome.runtime.on-message.add-listener
if req.update-images
  fetch-image!
