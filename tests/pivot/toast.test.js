/**
 * @jest-environment jsdom
 */

import { toast } from '../../src/js/pivot/toast';

describe('toast', () => {
  beforeEach(() => {
    document.body.innerHTML = ''; // Clear DOM before each test
  });

  test('should create a toast container if it does not exist', () => {
    toast({ message: 'Test message' });
    const toastContainer = document.getElementById('toast-container');
    expect(toastContainer).not.toBeNull();
  });

  test('should use default values when properties are not provided', () => {
    toast({ message: 'Test message' });
    const toastElement = document.querySelector('#toast-container > div');
    expect(toastElement).not.toBeNull();
    expect(toastElement.classList.contains('info')).toBe(true);
    const headerText = toastElement.querySelector('header').textContent.replace(/\s+/g, ' ').trim();
    expect(headerText).toContain('ℹ️ Info');
  });

  test('should apply custom properties when provided', () => {
    toast({
      message: 'Custom message',
      type: 'success',
      title: 'Custom Title',
      icon: '✅',
      duration: 0,
    });
    const toastElement = document.querySelector('#toast-container > div');
    expect(toastElement).not.toBeNull();
    expect(toastElement.classList.contains('success')).toBe(true);
    const headerText = toastElement.querySelector('header').textContent.replace(/\s+/g, ' ').trim();
    expect(headerText).toContain('✅ Custom Title');
    expect(toastElement.querySelector('p').textContent).toBe('Custom message');
  });

  test('should not remove the toast if duration is 0', () => {
    jest.useFakeTimers();
    toast({ message: 'Persistent message', duration: 0 });
    const toastElement = document.querySelector('#toast-container > div');
    expect(toastElement).not.toBeNull();
    jest.advanceTimersByTime(5000);
    expect(document.querySelector('#toast-container > div')).not.toBeNull();
    jest.useRealTimers();
  });

  test('should remove the toast after the specified duration', () => {
    jest.useFakeTimers();
    toast({ message: 'Timed message', duration: 500 });
    const toastElement = document.querySelector('#toast-container > div');
    expect(toastElement).not.toBeNull();
    jest.advanceTimersByTime(1000);
    expect(document.querySelector('#toast-container > div')).toBeNull();
    jest.useRealTimers();
  });
  
  test('should close the toast when the close button is clicked', () => {
    jest.useFakeTimers();
    toast({ message: 'Closable message' });
    const closeButton = document.querySelector('#toast-container button.close');
    expect(closeButton).not.toBeNull();
    closeButton.click();
    jest.advanceTimersByTime(1000);
   
    expect(document.querySelector('#toast-container > div')).toBeNull();
    jest.useRealTimers();
  });
});
