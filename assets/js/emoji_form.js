export function activateEmojiPicker(inputSelector) {
  if($(inputSelector).length > 0) {
    addEmojiPicker(inputSelector)
    removeAnythingOtherThanEmojisFromInput(inputSelector)
  }
}

function addEmojiPicker(inputSelector) {
  require('jquery-textcomplete')
  require('emojione')
  require('emojionearea')

  $(document).ready(() => {
    $(inputSelector).emojioneArea({
      pickerPosition: "right",
      searchPlaceholder: 'Search',
      shortcuts: false
    })

    $(inputSelector).data('emojioneArea').editor.focus()
  })
}

function removeAnythingOtherThanEmojisFromInput(inputSelector) {
  $(inputSelector).parent().on('focusout', '.emojionearea-editor', function() {
    $(this).contents().filter(function() {
      return this.nodeType == 3
    }).remove()
  })

  $(document).on('change', inputSelector, function() {
    const content = $(this).val()
    const newContent = content.replace(/\w+/gi, '')

    $(this).val(newContent)
  })
}
