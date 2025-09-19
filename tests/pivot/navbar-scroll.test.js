/**
 * @jest-environment jsdom
 */

import { navbarScroll } from '../../src/js/pivot/navbar-scroll';

describe('navbarScroll', () => {
  beforeEach(() => {
    document.body.innerHTML = `
      <div id="header" class=""></div>
    `;
    window.scrollY = 0;
    navbarScroll();
  });

  it('should add "fixed" class when scroll position is greater than 100', () => {
    window.scrollY = 150;
    window.dispatchEvent(new Event('scroll')); // Trigger scroll event
    const header = document.getElementById('header');
    expect(header.classList.contains('fixed')).toBe(true);
  });

  it('should remove "fixed" class when scroll position is less than or equal to 100', () => {
    const header = document.getElementById('header');
    header.classList.add('fixed');
    window.scrollY = 50;
    window.dispatchEvent(new Event('scroll'));
    expect(header.classList.contains('fixed')).toBe(false);
  });
});
