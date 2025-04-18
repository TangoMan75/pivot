/**
 * @jest-environment jsdom
 */

import { navbarScroll } from '../../src/js/dom/navbar-scroll';

describe('navbarScroll', () => {
  beforeEach(() => {
    // Set up the DOM
    document.body.innerHTML = `
      <div id="header" class=""></div>
    `;
    // Mock the scroll event listener
    window.scrollY = 0; // Initial scroll position
    navbarScroll(); // Initialize function
  });

  it('should add "is-fixed" class when scroll position is greater than 100', () => {
    // Simulate scrolling
    window.scrollY = 150; // Set scroll position
    window.dispatchEvent(new Event('scroll')); // Trigger scroll event

    const header = document.getElementById('header');
    expect(header.classList.contains('is-fixed')).toBe(true);
  });

  it('should remove "is-fixed" class when scroll position is less than or equal to 100', () => {
    // Add the class initially
    const header = document.getElementById('header');
    header.classList.add('is-fixed');

    // Simulate scrolling
    window.scrollY = 50; // Set scroll position
    window.dispatchEvent(new Event('scroll')); // Trigger scroll event

    expect(header.classList.contains('is-fixed')).toBe(false);
  });
});
