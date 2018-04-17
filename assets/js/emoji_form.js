export function addEmojiPicker(inputSelector) {
  if($(inputSelector).length > 0) {
    activateEmojiPicker(inputSelector)
  }
}

function activateEmojiPicker(inputSelector) {
  require('jquery-textcomplete')
  // Fetching emojione from the CDN because otherwise it breaks the application
  // when used with brunch build --production.
  // require('emojione')
  require('emojionearea')

  $(document).ready(() => {
    $(inputSelector).emojioneArea({
      pickerPosition: "right",
      searchPlaceholder: 'Search',
      shortcuts: false
    })

    executeCallbackWhenEmojiOneEditorExists(inputSelector, () => {
      $(inputSelector).data('emojioneArea').editor.focus()

      removeAnythingOtherThanEmojisFromInput(inputSelector)
    })
  })
}

function executeCallbackWhenEmojiOneEditorExists(inputSelector, callback) {
  const editor = $(inputSelector).data('emojioneArea').editor

  if(editor) {
    callback()
  } else {
    setTimeout(() => {
      executeCallbackWhenEmojiOneEditorExists(inputSelector, callback)
    }, 100)
  }
}

function removeAnythingOtherThanEmojisFromInput(inputSelector) {
  $(inputSelector).data('emojioneArea').editor.on('focusout', function() {
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
