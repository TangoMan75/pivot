/**
 * remove element with fade out animation
 */
export const removeElement = (e) => {
  if (e) {
    e.style.transition = 'opacity 0.5s ease-in-out';
    e.style.opacity = '0';
    setTimeout(() => {
      e.remove();
    }, 500);
  }
}