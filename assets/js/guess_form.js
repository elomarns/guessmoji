export function showEmojiContentUsingEmojiOneImages(labelSelector, emojiMetadataContainerSelector) {
  $(document).ready(() => {
    const label = $(labelSelector)

    if(label.length > 0) {
      const emojiShortname = $(emojiMetadataContainerSelector).data('emoji-content')
      const emojisAsImages = emojione.shortnameToImage(emojiShortname)
      label.find('.guess_emoji_content').html(emojisAsImages)
    }
  })
}

export function activateEmojiTipLink(linkSelector, emojiMetadataContainerSelector) {
  $(document).on('click', linkSelector, function(event) {
    $(this).hide()

    const tip = $(emojiMetadataContainerSelector).data('emoji-tip')
    const tipContainer = $('<span>').html(tip)
    $(this).after(tipContainer)

    event.preventDefault()
  })
}

export function activateEmojiDecodedContentButton(buttonSelector, 
  emojiMetadataContainerSelector, guessContentInputSelector) {
  $(document).on('click', buttonSelector, function() {
    const emojiDecodedContent = 
      $(emojiMetadataContainerSelector).data('emoji-decoded-content')
    const emojiDecodedContentContainer = $('<p>')
        .attr('id', 'emoji_decoded_content')
        .html('Answer: ' + emojiDecodedContent)
    $(guessContentInputSelector).parent().after(emojiDecodedContentContainer)

    $(guessContentInputSelector).remove()
    $(this).parent().remove()
  })
}
