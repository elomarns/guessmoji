export function showEmojiContentUsingEmojiOneImages(labelSelector) {
  $(document).ready(() => {
    const label = $(labelSelector)

    if(label.length > 0) {
      const emojiShortname = label.data("emoji-content")
      const emojisAsImages = emojione.shortnameToImage(emojiShortname)
      label.find(".guess_emoji_content").html(emojisAsImages)
    }
  })
}

export function activateEmojiTipLink(linkSelector) {
  $(document).on('click', linkSelector, function(event) {
    $(this).hide()

    const tipContainer = $(this).siblings('[data-emoji-tip]')
    const tip = tipContainer.data('emoji-tip')
    tipContainer.html(tip)

    event.preventDefault()
  })
}

export function addTwitterShareButton(buttonContainerSelector, emojiMetadataContainerSelector) {
  $(document).ready(() => {  
    addTwitterShareLink(buttonContainerSelector, emojiMetadataContainerSelector)
    addTwitterJavaScriptFile()
  })  
}

function addTwitterShareLink(containerSelector, emojiMetadataContainerSelector) {
  const emojisAsShortnames = $(emojiMetadataContainerSelector).data('emoji-content')
  const emojisAsUnicode = emojione.shortnameToUnicode(emojisAsShortnames)

  const link = $('<a/>')
    .attr('href', 'https://twitter.com/share?ref_src=twsrc%5Etfw')
    .addClass('twitter-share-button')
    .attr('data-text', 'Guess the movie from the emojis: ' + emojisAsUnicode)
    .attr('data-size', 'large')
    .data('show-count', true)
    .html('Tweet') 

  $(containerSelector).append(link)
}

function addTwitterJavaScriptFile() {
  var script = document.createElement('script')
  script.setAttribute('src', 'https://platform.twitter.com/widgets.js')
  script.setAttribute('charset', 'utf-8')
  document.head.appendChild(script)
}
