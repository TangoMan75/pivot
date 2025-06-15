/**
 * animate
 */
export const animate = (element) => {
  if (!element) return;
  const animation = element.dataset.animation || 'spin';
  const duration = element.dataset.duration || 440;

  element.classList.add(animation);
  element.classList.add('remove-pseudo-elements');

  setTimeout(() => {
    element.classList.remove(animation);
    element.classList.remove('remove-pseudo-elements');
  }, duration);
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