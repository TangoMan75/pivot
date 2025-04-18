![GH language](https://img.shields.io/github/languages/top/TangoMan75/pivot)
[![GH release](https://img.shields.io/github/v/release/TangoMan75/pivot)](https://github.com/TangoMan75/pivot/releases)
![GH license](https://img.shields.io/github/license/TangoMan75/pivot)
![GH stars](https://img.shields.io/github/stars/TangoMan75/pivot)
![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2FTangoMan75%2Fpivot&labelColor=%23697689&countColor=%2337d67a&style=flat)

💫 TangoMan Pivot CSS
=====================

<img src="dist/images/dizzy.svg" align="left" width="96" style="margin-right: 1em">

TangoMan Pivot CSS is a lightweight extension of [pico.css](https://picocss.com), (the minimal CSS framework for semantic HTML)
focused on providing a boilerplate for building single page applications.

📚 Documentation
----------------

Documentation can be found here : [https://tangoman75.github.io/pivot](https://tangoman75.github.io/pivot)

🎯 Features
-----------

### ⚡ Colors

Avoids loading the whole [pico.css's color palette](https://github.com/picocss/pico/blob/main/css/pico.colors.css).
When we just need a small subset of variables for _success_, _warning_, and _danger_ elements.

### ⚡ Layout Enhancements

Adds a `flex` class for flexible layouts.

Provides a `list--bare` class to remove bullets from list items.

### ⚡ Scroll Behavior

Enables smooth scrolling with `scroll-behavior: smooth`.

Sets `scroll-margin-top` for `<main>`, `<section>`, and `<article>` elements for better navigation.

### ⚡ Section Styling

Styles section headers with a bottom border.

### ⚡ Table Styling

Styles table headers within `<tbody>` with bold font weight and `nowrap`.

Alternating row background colors for improved readability.

### ⚡ Icon Integration

Provides a generic `icon-svg` class for SVG icons.

Adds specific icon classes for checkbox, minus, chevron, date, time, search, close, loading, valid, and invalid icons, utilizing pico.css's built in icon variables.

### ⚡ Form Styling

Customizes `<fieldset>` appearance with padding, border, and `<legend>` styles.

### ⚡ Alert Messages

Adds styled alert messages with _info_, _success_, _warning_, and _danger_ variations, with custom colorations.

### ⚡ Semantic Buttons

Adds styled buttons with "success," "warning," and "danger" states.

### ⚡ Close Button

Provides a `close` class for styled close buttons.

### ⚡ Footer Styling

Styles the `<footer>` with a flexible layout and list styles.

### ⚡ Navbar Enhancements

Improves `<navbar>` layout and adds a sticky header effect for larger screens with a blur effect.

Adds a divider to icon groups within the navbar.

_(Style copied from [picocss.com](https://picocss.com) landing page.)_

### ⚡ Icon Groups

Adds a general icon class for inline icon styling.

_(Style copied from [picocss.com](https://picocss.com) landing page.)_

### ⚡ Theme Toggle

Adds styling for theme toggle icons with animations.

_(Style copied from [picocss.com](https://picocss.com) landing page.)_

## ▶️ Usage

1.  **Include pico.css:** Ensure you have pico.css included in your project.
2.  **Include TangoMan Pivot CSS:** Add `pivot.css` to your project and include it after pico.css.
3.  **Use the provided classes:** Apply the classes defined in `pivot.css` to your HTML elements.

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Pico CSS Project</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css">
    <link rel="stylesheet" href="./css/pivot.css">
</head>
<body>
    <main class="container">
        <section>
            <header>
                <h2>Example Section</h2>
            </header>
            <p>This is a section with custom styles.</p>
            <div class="flex">
                <div>Item 1</div>
                <div>Item 2</div>
                <div>Item 3</div>
            </div>
            <ul class="list--bare">
                <li>Item without bullets</li>
                <li>Another item</li>
            </ul>
            <article>
                <header><h3>An article</h3></header>
                <p>This article has scroll margin.</p>
            </article>
        </section>
        <div class="alert alert--success">
            <header>Success!</header>
            <p>This is a success alert.</p>
            <footer>More information here.</footer>
            <button class="close"></button>
        </div>
    </main>
    <footer class="footer container">
        <ul>
            <li>item 1</li>
            <li>item 2</li>
        </ul>
        <p>Copyright 2025</p>
    </footer>
</body>
</html>
```

## 🚀 Installation

### 🚨 Production

You can download `pivot.css` from the [GitHub repository](https://github.com/TangoMan75/pivot) or include it via CDN.

### ✅ Development

To setup your development environment, follow these steps:

1. **Install Dependencies:**

If you have yarn installed, run the following command in the project's root directory:

```bash
yarn install
```

This command installs all the necessary development dependencies.

2. **Run Development Scripts:**

To start the development environment or build the CSS, use the following command:

```bash
yarn run
```

This command will execute the default script defined in the `package.json` file.

You can run specific scripts like so:

```bash
# watch dev folder
yarn watch
# lint scss
yarn lint
# build css
yarn build
```

🤝 Contributing
---------------

Thank you for your interrest in contributing to **TangoMan Pivot CSS**.

Please review the [code of conduct](./CODE_OF_CONDUCT.md) and [contribution guidelines](./CONTRIBUTING.md) before starting to work on any features.

If you want to open an issue, please check first if it was not [reported already](https://github.com/TangoMan75/pivot/issues) before creating a new one.

📜 License
----------

Copyrights (c) 2025 &quot;Matthias Morin&quot; &lt;mat@tangoman.io&gt;

[![License](https://img.shields.io/badge/Licence-MIT-green.svg)](LICENSE)
Distributed under the MIT license.

If you like **TangoMan Pivot CSS** please star, follow or tweet:

[![GitHub stars](https://img.shields.io/github/stars/TangoMan75/pivot?style=social)](https://github.com/TangoMan75/pivot/stargazers)
[![GitHub followers](https://img.shields.io/github/followers/TangoMan75?style=social)](https://github.com/TangoMan75)
[![Twitter](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2FTangoMan75%2Fshoe)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2FTangoMan75%2Fshoe)

... And check my other cool projects.

🙏 Acknowledgements
-------------------

- [picocss](https://picocss.com): Minimal CSS Framework for semantic HTML
- [prismjs](https://prismjs.com): Lightweight syntax highlighter
- [cbracco](https://cbracco.github.io/html5-test-page): html5-test-page
