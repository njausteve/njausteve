// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"
import 'alpinejs';

// uncomment when liveview is integrated
// const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
// const liveSocket = new LiveSocket("/live", Socket, {
//   dom: {
//     onBeforeElUpdated(from, to) {
//       if (from.__x) {
//         window.Alpine.clone(from.__x, to);
//       }
//     },
//   },
//   params: {_csrf_token: csrfToken}
// });

// // webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
