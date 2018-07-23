// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
import { addEmojiPicker } from "./emoji_form"
addEmojiPicker('#emoji_content')

import { showEmojiContentUsingEmojiOneImages, activateEmojiTipLink, 
  activateEmojiDecodedContentButton } from "./guess_form"
showEmojiContentUsingEmojiOneImages('label[for="guess_content"]', '#new_guess')
activateEmojiTipLink('#show_tip', '#new_guess')
activateEmojiDecodedContentButton('#show_emoji_decoded_content', 
  '#new_guess', '#guess_content')

import { addTwitterShareButton } from "./twitter"
addTwitterShareButton('#social_networks_links', '#new_guess')

import { addFacebookShareButton } from "./facebook"
addFacebookShareButton('#social_networks_links')
