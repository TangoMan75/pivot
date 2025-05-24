/**
 * @jest-environment jsdom
 */

import { animate, initAnimatedElementsEventListeners } from '../../src/js/pivot/animate';

describe('animate', () => {
  let element;

  beforeEach(() => {
    element = document.createElement('div');
    element.dataset.animation = 'spin';
    document.body.appendChild(element);
  });

  afterEach(() => {
    document.body.innerHTML = '';
  });

  it('should add and remove animation classes', () => {
    jest.useFakeTimers();
    animate(element);

    expect(element.classList.contains('spin')).toBe(true);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(true);

    jest.advanceTimersByTime(440);

    expect(element.classList.contains('spin')).toBe(false);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(false);

    jest.useRealTimers();
  });

  it('should do nothing if element is null', () => {
    expect(() => animate(null)).not.toThrow();
  });
});

describe('initAnimatedElementsEventListeners', () => {
  let element;

  beforeEach(() => {
    element = document.createElement('div');
    element.classList.add('animate');
    element.dataset.animation = 'spin';
    document.body.appendChild(element);
  });

  afterEach(() => {
    document.body.innerHTML = '';
  });

  it('should add click event listener to elements with class "animate"', () => {
    const spy = jest.spyOn(element, 'addEventListener');
    initAnimatedElementsEventListeners();

    expect(spy).toHaveBeenCalledWith('click', expect.any(Function));
  });

  it('should trigger animation on click', () => {
    jest.useFakeTimers();
    initAnimatedElementsEventListeners();

    element.click();

    expect(element.classList.contains('spin')).toBe(true);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(true);

    jest.advanceTimersByTime(440);

    expect(element.classList.contains('spin')).toBe(false);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(false);

    jest.useRealTimers();
  });
});
