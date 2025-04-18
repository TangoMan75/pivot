/**
 * TangoMan Pivot CSS
 *
 * @author  "Matthias Morin" <mat@tangoman.io>
 * @version 0.1.0
 * @license MIT
 * @link    https://picocss.com
 * @link    https://github.com/TangoMan75/copicss
 */

/**
 * copy text to clipboard
 */
function copyToClipboard(str) {
  navigator.permissions.query({ name: 'clipboard-write' }).then((result) => {
    if (result.state === 'granted' || result.state === 'prompt') {
      navigator.clipboard.writeText(str);
    }
  });
}

/**
 * init eventListeners for icons
 */
[...document.querySelectorAll('.fa-solid, .fa-brands')].forEach((el) => el.addEventListener('click', () => {
  copyToClipboard(event.target.classList);
  toast({
    fonticon: `${event.target.classList}`,
    title: `${event.target.classList}`,
    message: `<strong>"${event.target.classList}"</string> copied to clipboard !`,
  });
}));
