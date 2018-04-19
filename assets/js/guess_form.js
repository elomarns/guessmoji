export function showEmojiContentUsingEmojiOneImages(labelSelector) {
  $(document).ready(function() {
    const guessContentLabel = $(labelSelector)

    if(guessContentLabel.length > 0) {
      let emojiAsUnicode = guessContentLabel.data('emoji-content')
      var emojiAsImage = emojione.unicodeToImage(emojiAsUnicode)

      guessContentLabel.find('.guess_emoji_content').html(emojiAsImage)
    }
  })
}
