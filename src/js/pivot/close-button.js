/**
 * close button
 */
export const closeButtonTemplate = (targetId) => {
    let ariaControls = '';
    if (targetId) {
        ariaControls = ` aria-controls="${targetId}"`;
    }

    return `<button class="close" tabindex="-1" role="button" aria-label="Close"${ariaControls}></button>`;
};

export const closeButton = (targetId) => {
    const parser = new DOMParser();
    const doc = parser.parseFromString(closeButtonTemplate(targetId), 'text/html');
    return doc.body.firstChild;
};