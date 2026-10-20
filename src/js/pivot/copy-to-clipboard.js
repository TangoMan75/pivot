/**
 * copy text to clipboard
 */
export const copyToClipboard = (str) => {
    return navigator.clipboard.writeText(str);
};