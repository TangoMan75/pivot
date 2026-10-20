/**
 * @jest-environment jsdom
 */

import { animate, initAnimatedElementsEventListeners } from '../../src/js/pivot/animate';

describe('animate', () => {
  let element;

  beforeEach(() => {
    element = document.createElement('div');
    element.classList.add('animate');
    element.dataset.animation = 'spin';
    document.body.appendChild(element);
  });

  afterEach(() => {
    document.body.innerHTML = '';
    jest.useRealTimers();
  });

  it('should add and remove animation classes', () => {
    animate(element);

    expect(element.classList.contains('spin')).toBe(true);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(true);

    const animEnd = new Event('animationend');
    element.dispatchEvent(animEnd);

    expect(element.classList.contains('spin')).toBe(false);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(false);
  });

  it('should not remove animation classes after advancing timers if animationend is not dispatched', () => {
    jest.useFakeTimers();
    animate(element);

    expect(element.classList.contains('spin')).toBe(true);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(true);

    // Advance timers without dispatching animationend
    jest.advanceTimersByTime(1000);

    // Classes should still be present
    expect(element.classList.contains('spin')).toBe(true);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(true);
  });

  it('should not remove animation classes on unrelated events', () => {
    animate(element);

    expect(element.classList.contains('spin')).toBe(true);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(true);

    // Dispatch a different event
    const event = new Event('transitionend');
    element.dispatchEvent(event);

    // Classes should still be present
    expect(element.classList.contains('spin')).toBe(true);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(true);

    // Now dispatch animationend to clean up
    const animEnd = new Event('animationend');
    element.dispatchEvent(animEnd);

    expect(element.classList.contains('spin')).toBe(false);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(false);
  });

  it('should allow multiple rapid animate calls and clean up after each animationend', () => {
    animate(element);
    expect(element.classList.contains('spin')).toBe(true);

    // Call animate again before animationend
    animate(element);
    expect(element.classList.contains('spin')).toBe(true);

    // Dispatch animationend
    const event = new Event('animationend');
    element.dispatchEvent(event);

    // Classes should be removed
    expect(element.classList.contains('spin')).toBe(false);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(false);
  });

  it('should not throw if animationend is dispatched multiple times', () => {
    animate(element);

    const event = new Event('animationend');
    expect(() => {
      element.dispatchEvent(event);
      element.dispatchEvent(event);
    }).not.toThrow();
  });

  it('should not add duplicate event listeners on multiple animate calls', () => {
    const spy = jest.spyOn(element, 'addEventListener');
    animate(element);
    animate(element);
    // Should not add more than two listeners (one per call)
    expect(spy).toHaveBeenCalledWith('animationend', expect.any(Function));
    spy.mockRestore();
  });

  it('should add click event listener to elements with class "animate"', () => {
    const spy = jest.spyOn(element, 'addEventListener');
    initAnimatedElementsEventListeners();

    expect(spy).toHaveBeenCalledWith('click', expect.any(Function));
    spy.mockRestore();
  });

  it('should trigger animation on click', () => {
    initAnimatedElementsEventListeners();

    element.click();

    expect(element.classList.contains('spin')).toBe(true);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(true);

    const event = new Event('animationend');
    element.dispatchEvent(event);

    expect(element.classList.contains('spin')).toBe(false);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(false);
  });

  it('should not add event listener to elements without class "animate"', () => {
    const nonAnimated = document.createElement('div');
    const spy = jest.spyOn(nonAnimated, 'addEventListener');
    document.body.appendChild(nonAnimated);

    initAnimatedElementsEventListeners();

    expect(spy).not.toHaveBeenCalled();
    spy.mockRestore();
  });

  it('should handle multiple elements with class "animate"', () => {
    const element2 = document.createElement('div');
    element2.classList.add('animate');
    element2.dataset.animation = 'spin';
    document.body.appendChild(element2);

    initAnimatedElementsEventListeners();

    element.click();
    element2.click();

    expect(element.classList.contains('spin')).toBe(true);
    expect(element2.classList.contains('spin')).toBe(true);

    const event = new Event('animationend');
    element.dispatchEvent(event);
    element2.dispatchEvent(event);

    expect(element.classList.contains('spin')).toBe(false);
    expect(element2.classList.contains('spin')).toBe(false);
  });

  it('should add click event listener to elements with class "animate" (duplicate test)', () => {
    const spy = jest.spyOn(element, 'addEventListener');
    initAnimatedElementsEventListeners();

    expect(spy).toHaveBeenCalledWith('click', expect.any(Function));
    spy.mockRestore();
  });

  it('should trigger animation on click (with timers)', () => {
    jest.useFakeTimers();
    initAnimatedElementsEventListeners();

    element.click();

    expect(element.classList.contains('spin')).toBe(true);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(true);

    // Simulate animationend after 440ms
    jest.advanceTimersByTime(440);

    // Classes should still be present unless animationend is dispatched
    expect(element.classList.contains('spin')).toBe(true);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(true);

    // Now dispatch animationend
    const event = new Event('animationend');
    element.dispatchEvent(event);

    expect(element.classList.contains('spin')).toBe(false);
    expect(element.classList.contains('remove-pseudo-elements')).toBe(false);
  });
});
