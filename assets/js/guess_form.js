import { unicodeToImages } from "./emoji"

export function showEmojiContentUsingEmojiOneImages(labelSelector) {
  $(document).ready(() => {
    const label = $(labelSelector)

    if(label.length > 0) {
      const emojisAsUnicode = label.data('emoji-content')
      const emojisAsImages = unicodeToImages(emojisAsUnicode)
      label.find('.guess_emoji_content').html(emojisAsImages)
    }
  })
}
