/**
 * navbar scroll
 */
export const navbarScroll = () => {
  window.addEventListener('scroll', () => {
    const header = document.getElementById('header');
    if (window.scrollY > 100) {
      header.classList.add('fixed');
    } else {
      header.classList.remove('fixed');
    }
  });
};