id-or-url = document.get-element-by-id \id-or-url

save-options = ->
  chrome.storage.sync.set do
    id-or-url: id-or-url.value

chrome.storage.sync.get do
  \idOrUrl
  (item)->
    id-or-url.value = item.id-or-url

save-button = document.get-element-by-id \save-button
save-button.add-event-listener \click, save-options
