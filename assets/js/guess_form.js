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
