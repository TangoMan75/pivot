/**
 * animate
 */
export const animate = (element) => {
  if (!element) return;
  const animation = element.dataset.animation || 'spin';

  element.classList.add(animation);
  element.classList.add('remove-pseudo-elements');
  setTimeout(() => {
    element.classList.remove(animation);
    element.classList.remove('remove-pseudo-elements');
  }, 440);
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