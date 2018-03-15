export function activateEmojiPicker() {
  $(document).ready(function() {
    $('#emoji_content').emojioneArea({
      pickerPosition: "right",
      searchPlaceholder: 'Search',
      shortcuts: false
    });
  });
}
