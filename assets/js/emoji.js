export function replaceProblematicEmojis(emojisAsUnicode) {
  return emojisAsUnicode.replace('⬆', '⬆️')
}

export function unicodeToImages(emojisAsUnicode) {
  const iterator = emojisAsUnicode[Symbol.iterator]()
  let currentEmoji
  let emojisAsImages = ""

  while(currentEmoji = iterator.next().value) {
    currentEmoji = replaceProblematicEmojis(currentEmoji)

    if(currentEmoji != "") {
      emojisAsImages += emojione.unicodeToImage(currentEmoji);
    }
  }

  emojisAsImages = $(emojisAsImages).addClass('emojioneemoji')

  return emojisAsImages
}
