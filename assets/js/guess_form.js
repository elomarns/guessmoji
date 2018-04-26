export function showEmojiContentUsingEmojiOneImages(labelSelector) {
  $(document).ready(() => {
    const label = $(labelSelector)

    if(label.length > 0) {
      const emojisAsUnicode = label.data('emoji-content')
      const emojisAsImages = emojione.shortnameToImage(emojisAsUnicode)
      label.find('.guess_emoji_content').html(emojisAsImages)
    }
  })
}
