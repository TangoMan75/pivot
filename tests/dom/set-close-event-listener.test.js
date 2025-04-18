/**
 * @jest-environment jsdom
 */

import { removeElement } from '../../src/js/dom/remove-element';
import { setCloseEventListener } from '../../src/js/dom/set-close-event-listener';

jest.mock('../../src/js/dom/remove-element', () => ({
  removeElement: jest.fn(),
}));

describe('setCloseEventListener', () => {
  let mockElement;
  let mockTargetElement;

  beforeEach(() => {
    mockTargetElement = document.createElement('div');
    mockTargetElement.id = 'targetElement';
    document.body.appendChild(mockTargetElement);

    mockElement = document.createElement('button');
    mockElement.setAttribute('aria-controls', 'targetElement');
  });

  afterEach(() => {
    document.body.innerHTML = '';
  });

  it('should add a click event listener', () => {
    const addEventListenerSpy = jest.spyOn(mockElement, 'addEventListener');
    setCloseEventListener(mockElement);
    expect(addEventListenerSpy).toHaveBeenCalledWith('click', expect.any(Function));
    addEventListenerSpy.mockRestore();
  });

  it('should remove the target element when clicked', () => {
    setCloseEventListener(mockElement);
    mockElement.click();
    expect(removeElement).toHaveBeenCalledWith(mockTargetElement);
    expect(removeElement).toHaveBeenCalledTimes(1)
  });

  it('should not throw an error if the target element does not exist', () => {
    mockElement.dataset.target = 'nonExistentElement';
    setCloseEventListener(mockElement);
    expect(() => {
        mockElement.click();
    }).not.toThrow();
  });

  it('should not throw an error if the target element already removed', () => {
    setCloseEventListener(mockElement);
    mockElement.click();
    expect(() => {
        mockElement.click();
    }).not.toThrow();
  });
});