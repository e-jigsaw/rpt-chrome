document.body.add-event-listener do
  \keydown
  (event)->
    if event.key-code is 32
      item <- chrome.storage.sync.get \isSafeMode
      chrome.storage.sync.set do
        is-safe-mode: !item.is-safe-mode

image-el = document.get-element-by-id \image

chrome.storage.sync.get do
  [\idOrUrl, \isSafeMode]
  (item)->
    image-el.set-attribute do
      \style
      if item.is-safe-mode
        'width:100%;height:100%;background-image:url(\'https://media.giphy.com/media/RVNLmBzQtdCSI/giphy.gif\');background-repeat:no-repeat;background-size:contain;background-position:center;background-color:#C3F2FF;'
      else
        "width:100%;height:100%;background-image:url('http://rpt.jgs.me/r/#{item.id-or-url}');background-repeat:no-repeat;background-size:contain;background-position:center;background-color:#36465d;"
