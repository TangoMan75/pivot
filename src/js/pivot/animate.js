/**
 * animate
 */
export const animate = (element) => {
  if (!element) return;
  const animation = element.dataset.animation || 'spin';

  element.classList.add(animation);
  element.classList.add('remove-pseudo-elements');

  element.addEventListener('animationend', function handler() {
    element.classList.remove(animation);
    element.classList.remove('remove-pseudo-elements');
    element.removeEventListener('animationend', handler);
  });
};

/**
 * init eventListeners for animated elements
 */
export const initAnimatedElementsEventListeners = () => {
  [...document.getElementsByClassName('animate')].forEach((element) => {
    element.addEventListener('click', () => {
      animate(element);
    });
  });
};