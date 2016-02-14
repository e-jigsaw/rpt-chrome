document.body.add-event-listener do
  \keydown
  (event)->
    if event.key-code is 32
      item <- chrome.storage.sync.get \isSafeMode
      chrome.storage.sync.set do
        is-safe-mode: !item.is-safe-mode

image-el = document.get-element-by-id \image

{is-safe-mode} <- chrome.storage.sync.get \isSafeMode
if is-safe-mode
  return image-el.set-attribute do
    \style
    'width:100%;height:100%;background-image:url(\'https://media.giphy.com/media/RVNLmBzQtdCSI/giphy.gif\');background-repeat:no-repeat;background-size:contain;background-position:center;background-color:#C3F2FF;'

{images} <- chrome.storage.local.get \images
url = images.shift!

try
  if url isnt undefined
    image-el.set-attribute do
      \style
      "width:100%;height:100%;background-image:url('#{url}');background-repeat:no-repeat;background-size:contain;background-position:center;background-color:#36465d;"
catch err
  console.error err

<- chrome.storage.local.set do
  images: images

if images.length < 10
  chrome.runtime.send-message do
    update-images: true
