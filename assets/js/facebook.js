export function addFacebookShareButton(buttonContainerSelector) {
  $(document).ready(() => {
    if($(buttonContainerSelector).length > 0) {
      addFacebookDiv(buttonContainerSelector)
      addFacebookJavaScriptFile()
      addFacebookShareLink(buttonContainerSelector)  
    }
  })
}

function addFacebookDiv(containerSelector) {
  if($('#fb-root').length == 0) {
    const div = $('<div>').attr('id', 'fb-root')    
    $(containerSelector).append(div)  
  }
}

function addFacebookJavaScriptFile() {
  if($('#facebook-jssdk').length == 0) {
    const script = $('<script>')
      .attr('src', 'https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.0&appId=175326889855001&autoLogAppEvents=1')
      .attr('id', 'facebook-jssdk')
          
    $('script:first').before(script)
  }
}

function addFacebookShareLink(containerSelector) {
  if($(containerSelector).find('.fb-share-button').length == 0) {
    const div = $('<div>')
      .addClass('fb-share-button')
      .attr('data-href', window.location.href)
      .attr('data-layout', 'button_count')
      .attr('data-size', 'large')
      .attr('data-mobile-iframe', true)

    const link = $('<a>')
      .attr('target', '_blank')
      .attr('href', 'https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fguessmoji.io%2F&amp;src=sdkpreparse')
      .attr('class', 'fb-xfbml-parse-ignore')
      .html('Share')

    div.append(link)
    $(containerSelector).append(div)
  }
}
