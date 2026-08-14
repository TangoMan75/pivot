/**
 * @jest-environment jsdom
 */

import { copyToClipboard } from '../../src/js/pivot/copy-to-clipboard';

describe('copyToClipboard', () => {
    beforeEach(() => {
        // Mock the clipboard API
        Object.assign(navigator, {
            clipboard: {
                writeText: jest.fn(),
            },
        });
    });

    it('should copy the provided text to the clipboard', async () => {
        const text = 'Test text';
        await copyToClipboard(text);
        expect(navigator.clipboard.writeText).toHaveBeenCalledWith(text);
    });
});
