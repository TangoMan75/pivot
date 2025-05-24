/**
 * The `removeElement` function removes an element from the DOM and
 * its controlled elements recursively. It also applies a fade-out
 * animation before removal.
 */
export const removeElement = (element) => {
  if (!element) return;

  element.style.transition = 'opacity 0.5s ease-in-out';
  element.style.opacity = '0';

  setTimeout(() => {
    element.remove();
  }, 500);

  const controlledId = element.getAttribute('aria-controls');
  if (controlledId) {
    const controlledElement = document.getElementById(controlledId);
    if (controlledElement) {
      removeElement(controlledElement);
    }
  }
};

/**
 * The `setCloseEventListener` function attaches a click event listener to an
 * element. When the element is clicked, the function retrieves the element
 * specified by the `aria-controls` attribute and removes it from the DOM.
 */
export const setCloseEventListener = (element) => {
  if (element) {
    element.addEventListener('click', (event) => {
      event.stopPropagation();
      const targetId = element.getAttribute('aria-controls');
      if (targetId) {
        removeElement(document.getElementById(targetId));
        return;
      }
  
      // if `aria-controls` is not set, we remove the parent element
      removeElement(element.parentElement);
    });
  }
};

/**
 * init eventListeners for close buttons
 */
export const initCloseButtonsEventListeners = () => {
  [...document.getElementsByClassName('close')].forEach((button) => {
    button.setAttribute('tabindex', '-1');
    setCloseEventListener(button);
  });
};