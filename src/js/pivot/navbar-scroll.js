/**
 * navbar scroll
 */
export const navbarScroll = () => {
  const header = document.getElementById('header');
  if (!header) return;

  window.addEventListener('scroll', () => {
    if (window.scrollY > 100) {
      header.classList.add('fixed');
    } else {
      header.classList.remove('fixed');
    }
  });
};