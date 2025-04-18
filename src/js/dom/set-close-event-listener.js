import { removeElement } from './remove-element';

/**
 * The `setCloseEventListener` function attaches a click event listener to an 
 * element. When the element is clicked, the function retrieves the element
 * specified by the `aria-controls` attribute and removes it from the DOM.
 */
export const setCloseEventListener = (el) => {
  if (el) {
    el.addEventListener('click', (event) => {
      event.stopPropagation();
      const targetId = el.getAttribute('aria-controls');
      if (targetId) {
        removeElement(document.getElementById(targetId));
      }
    });
  }
}