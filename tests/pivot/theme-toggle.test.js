/**
 * @jest-environment jsdom
 */

import { setTheme, initThemeToggleButtonEventListener } from '../../src/js/pivot/theme-toggle';

describe('theme-toggle.js', () => {
  let themeToggleButton;
  let themeIcon;

  beforeEach(() => {
    document.body.innerHTML = `
      <a id="theme-toggle">
        <svg></svg>
      </a>
    `;
    themeToggleButton = document.getElementById('theme-toggle');
    themeIcon = themeToggleButton.querySelector('svg');
    // reset dataset.theme
    delete document.documentElement.dataset.theme;
  });

  afterEach(() => {
    document.body.innerHTML = '';
  });

  describe('setTheme', () => {
    it('should set light theme by default (null)', () => {
      setTheme(null);
      expect(document.documentElement.dataset.theme).toBe('light');
      expect(themeToggleButton.getAttribute('aria-label')).toBe('Turn on dark mode');
      expect(themeIcon.classList.contains('moon')).toBe(false);
    });

    it('should set light theme by default (undefined)', () => {
      setTheme();
      expect(document.documentElement.dataset.theme).toBe('light');
      expect(themeToggleButton.getAttribute('aria-label')).toBe('Turn on dark mode');
      expect(themeIcon.classList.contains('moon')).toBe(false);
    });

    it('should set light theme correctly', () => {
      setTheme('light');
      expect(document.documentElement.dataset.theme).toBe('light');
      expect(themeToggleButton.getAttribute('aria-label')).toBe('Turn on dark mode');
      expect(themeIcon.classList.contains('moon')).toBe(false);
    });

    it('should set dark theme correctly', () => {
      setTheme('dark');
      expect(document.documentElement.dataset.theme).toBe('dark');
      expect(themeToggleButton.getAttribute('aria-label')).toBe('Turn off dark mode');
      expect(themeIcon.classList.contains('moon')).toBe(true);
    });
  });

  describe('initThemeToggleButtonEventListener', () => {
    it('should toggle theme on button click', () => {
      initThemeToggleButtonEventListener();

      // Simulate button click to switch to dark theme
      themeToggleButton.click();
      expect(document.documentElement.dataset.theme).toBe('dark');

      // Simulate button click to switch back to light theme
      themeToggleButton.click();
      expect(document.documentElement.dataset.theme).toBe('light');
    });
  });
});
