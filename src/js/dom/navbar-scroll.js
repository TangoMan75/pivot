export const navbarScroll = () => {
  window.addEventListener('scroll', () => {
    const header = document.getElementById('header');
    const scrollPosition = window.scrollY;
    if (scrollPosition > 100) {
      header.classList.add('is-fixed');
    } else {
      header.classList.remove('is-fixed');
    }
  });
}