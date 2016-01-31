image-el = document.get-element-by-id \image

chrome.storage.sync.get do
  \idOrUrl
  (item)->
    image-el.set-attribute do
      \style
      "width:100%;height:100%;background-image:url('http://rpt.jgs.me/r/#{item.id-or-url}');background-repeat:no-repeat;background-size:contain;background-position:center;background-color:#36465d;"
