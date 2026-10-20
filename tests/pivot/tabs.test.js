/**
 * @jest-environment jsdom
 */

import { setTabEventListener, initTabsEventListeners } from '../../src/js/pivot/tabs';

describe('setTabEventListener', () => {
    it('should set the clicked tab as selected and display its panel', () => {
        document.body.innerHTML = `
            <div role="tablist">
                <button role="tab" id="tab1" aria-controls="panel1">Tab 1</button>
                <button role="tab" id="tab2" aria-controls="panel2">Tab 2</button>
            </div>
            <div id="panel1" role="tabpanel">Panel 1</div>
            <div id="panel2" role="tabpanel">Panel 2</div>
        `;

        const tabs = [...document.querySelectorAll('[role="tab"]')];
        const tab1 = document.getElementById('tab1');
        const tab2 = document.getElementById('tab2');
        const panel1 = document.getElementById('panel1');
        const panel2 = document.getElementById('panel2');

        setTabEventListener(tab1, tabs);
        setTabEventListener(tab2, tabs);

        // Simulate clicking tab1
        tab1.click();
        expect(tab1.getAttribute('aria-selected')).toBe('true');
        expect(panel1.style.display).toBe('block');
        expect(panel1.getAttribute('aria-hidden')).toBe('false');
        expect(tab2.getAttribute('aria-selected')).toBe('false');
        expect(panel2.style.display).toBe('none');
        expect(panel2.getAttribute('aria-hidden')).toBe('true');

        // Simulate clicking tab2
        tab2.click();
        expect(tab2.getAttribute('aria-selected')).toBe('true');
        expect(panel2.style.display).toBe('block');
        expect(panel2.getAttribute('aria-hidden')).toBe('false');
        expect(tab1.getAttribute('aria-selected')).toBe('false');
        expect(panel1.style.display).toBe('none');
        expect(panel1.getAttribute('aria-hidden')).toBe('true');
    });
});

describe('initTabsEventListeners', () => {
    it('should initialize tabs and panels correctly', () => {
        document.body.innerHTML = `
            <div role="tablist">
                <button role="tab" id="tab1" aria-controls="panel1">Tab 1</button>
                <button role="tab" id="tab2" aria-controls="panel2">Tab 2</button>
            </div>
            <div id="panel1" role="tabpanel">Panel 1</div>
            <div id="panel2" role="tabpanel">Panel 2</div>
        `;

        initTabsEventListeners();

        const tab1 = document.getElementById('tab1');
        const tab2 = document.getElementById('tab2');
        const panel1 = document.getElementById('panel1');
        const panel2 = document.getElementById('panel2');

        // Verify initial state
        expect(tab1.getAttribute('aria-selected')).toBe('true');
        expect(panel1.style.display).toBe('block');
        expect(panel1.getAttribute('aria-hidden')).toBe('false');
        expect(tab2.getAttribute('aria-selected')).toBe('false');
        expect(panel2.style.display).toBe('none');
        expect(panel2.getAttribute('aria-hidden')).toBe('true');

        // Simulate clicking tab2
        tab2.click();
        expect(tab2.getAttribute('aria-selected')).toBe('true');
        expect(panel2.style.display).toBe('block');
        expect(panel2.getAttribute('aria-hidden')).toBe('false');
        expect(tab1.getAttribute('aria-selected')).toBe('false');
        expect(panel1.style.display).toBe('none');
        expect(panel1.getAttribute('aria-hidden')).toBe('true');
    });

    it('should not set default selected status when a tab is already selected', () => {
        document.body.innerHTML = `
            <div role="tablist">
                <button role="tab" id="tab1" aria-controls="panel1">Tab 1</button>
                <button role="tab" id="tab2" aria-controls="panel2" aria-selected="true">Tab 2</button>
            </div>
            <div id="panel1" role="tabpanel">Panel 1</div>
            <div id="panel2" role="tabpanel">Panel 2</div>
        `;

        initTabsEventListeners();

        const tab1 = document.getElementById('tab1');
        const tab2 = document.getElementById('tab2');
        const panel1 = document.getElementById('panel1');
        const panel2 = document.getElementById('panel2');

        // Verify initial state
        expect(tab2.getAttribute('aria-selected')).toBe('true');
        expect(panel2.style.display).toBe('block');
        expect(panel2.getAttribute('aria-hidden')).toBe('false');
        expect(tab1.getAttribute('aria-selected')).toBe('false');
        expect(panel1.style.display).toBe('none');
        expect(panel1.getAttribute('aria-hidden')).toBe('true');
    });
});
