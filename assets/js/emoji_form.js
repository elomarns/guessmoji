export function activateEmojiPicker() {
  $(document).ready(function() {
    $('#emoji_content').emojioneArea({
      pickerPosition: "right",
      searchPlaceholder: 'Search',
      shortcuts: false
    });
  });

  $(document).on('focusout', '.emojionearea-editor', function() {
    $(this).contents().filter(function() {
      return this.nodeType === 3
    }).remove()
  })

  $(document).on('change', '#emoji_content', function() {
    const content = $(this).val()
    const newContent = content.replace(/\w+/gi, '')

    $(this).val(newContent)
  })
}
