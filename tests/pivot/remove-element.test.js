import { removeElement } from '../../src/js/pivot/remove-element';

describe('removeElement', () => {
  let mockElement;
  let originalSetTimeout;

  beforeEach(() => {
    mockElement = {
      style: {},
      remove: jest.fn(),
      getAttribute: jest.fn(), // Mock getAttribute
    };
    originalSetTimeout = global.setTimeout;
    global.setTimeout = jest.fn(); // Mock setTimeout
  });

  afterEach(() => {
    global.setTimeout = originalSetTimeout; // Restore original setTimeout
  });

  it('should set the transition and opacity styles', () => {
    removeElement(mockElement);
    expect(mockElement.style.transition).toBe('opacity 0.5s ease-in-out');
    expect(mockElement.style.opacity).toBe('0');
  });

  it('should call setTimeout with the correct delay and callback', () => {
    removeElement(mockElement);
    expect(global.setTimeout).toHaveBeenCalledTimes(1);
    expect(global.setTimeout).toHaveBeenCalledWith(expect.any(Function), 500);
  });

  it('should remove the element after the timeout', () => {
    removeElement(mockElement);
    const callback = global.setTimeout.mock.calls[0][0]; // Extract the callback
    callback(); // Execute the callback
    expect(mockElement.remove).toHaveBeenCalledTimes(1);
  });
});
