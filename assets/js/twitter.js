export function addTwitterShareButton(buttonContainerSelector, emojiMetadataContainerSelector) {
  $(document).ready(() => {  
    if($(buttonContainerSelector).length > 0) {
      addTwitterShareLink(buttonContainerSelector, emojiMetadataContainerSelector)
      addTwitterJavaScriptFile()
    }
  })  
}

function addTwitterShareLink(containerSelector, emojiMetadataContainerSelector) {
  if($('.twitter-share-button').length == 0) {
    const emojisAsShortnames = 
      $(emojiMetadataContainerSelector).data('emoji-content')
    const emojisAsUnicode = 
      emojione.shortnameToUnicode(emojisAsShortnames)

    const link = $('<a>')
      .attr('href', 'https://twitter.com/share?ref_src=twsrc%5Etfw')
      .addClass('twitter-share-button')
      .attr('data-text', 'Guess the movie from the emojis: ' + emojisAsUnicode)
      .attr('data-size', 'large')
      .data('show-count', true)
      .html('Tweet') 

    $(containerSelector).append(link)
  }
}

function addTwitterJavaScriptFile() {
  if($('#twitter_js_sdk').length == 0) {
    const script = $('<script>')
      .attr('src', 'https://platform.twitter.com/widgets.js')
      .attr('charset', 'utf-8')
      .attr('id', 'twitter_js_sdk')

    $('script:first').before(script)  
  }
}
