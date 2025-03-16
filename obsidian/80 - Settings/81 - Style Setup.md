Appearance modifications

```json title:.obsidian/themes/AnuPpuccin/index.json
{
  "anuppuccin-theme-settings@@anuppuccin-theme-dark": "ctp-macchiato",
  "anuppuccin-theme-settings@@anuppuccin-light-theme-accents": "ctp-accent-light-teal",
  "anuppuccin-theme-settings@@anuppuccin-theme-accents": "ctp-accent-sapphire",
  "anuppuccin-theme-settings@@anuppuccin-accent-toggle": true,
  "anuppuccin-theme-settings@@ctp-custom-peach@@light": "#DD7F67",
  "anuppuccin-theme-settings@@ctp-custom-teal@@dark": "#11B7C5",
  "anuppuccin-theme-settings@@ctp-custom-teal@@light": "#1A7DA4",
  "anuppuccin-theme-settings@@ctp-custom-subtext1@@light": "#EE653A",
  "anuppuccin-theme-settings@@ctp-custom-subtext0@@dark": "#FB35D8",
  "anuppuccin-theme-settings@@ctp-custom-subtext0@@light": "#0C9FCE",
  "anuppuccin-theme-settings@@ctp-custom-overlay2@@dark": "#0AD1D0",
  "anuppuccin-theme-settings@@ctp-custom-overlay2@@light": "#353535",
  "anuppuccin-theme-settings@@ctp-custom-overlay1@@dark": "#FFA600",
  "anuppuccin-theme-settings@@ctp-custom-overlay1@@light": "#692525",
  "anuppuccin-theme-settings@@ctp-custom-overlay0@@dark": "#4CFFD2",
  "anuppuccin-theme-settings@@ctp-custom-overlay0@@light": "#0C9FCE",
  "anuppuccin-theme-settings@@ctp-custom-surface2@@light": "#E03F3F",
  "anuppuccin-theme-settings@@anp-active-line": "anp-no-highlight",
  "anuppuccin-theme-settings@@anp-callout-select": "anp-callout-sleek",
  "anuppuccin-theme-settings@@anp-callout-color-toggle": true,
  "anuppuccin-theme-settings@@anp-custom-checkboxes": true,
  "anuppuccin-theme-settings@@anp-speech-bubble": true,
  "anuppuccin-theme-settings@@tag-radius": 2,
  "anuppuccin-theme-settings@@anp-color-transition-toggle": true,
  "anuppuccin-theme-settings@@anp-cursor": "pointer",
  "anuppuccin-theme-settings@@anp-toggle-scrollbars": true,
  "anuppuccin-theme-settings@@anp-editor-font-source": "\"\"",
  "anuppuccin-theme-settings@@anp-editor-font-lp": "\"\"",
  "anuppuccin-theme-settings@@bold-weight": "700",
  "anuppuccin-theme-settings@@anp-font-live-preview-wt": "400",
  "anuppuccin-theme-settings@@anp-header-color-toggle": true,
  "anuppuccin-theme-settings@@anp-header-divider-color-toggle": true,
  "anuppuccin-theme-settings@@h1-weight": 700,
  "anuppuccin-theme-settings@@h2-weight": 700,
  "anuppuccin-theme-settings@@h3-weight": 700,
  "anuppuccin-theme-settings@@h4-weight": 700,
  "anuppuccin-theme-settings@@h5-weight": 700,
  "anuppuccin-theme-settings@@h6-size": 1.1,
  "anuppuccin-theme-settings@@h6-weight": 700,
  "anuppuccin-theme-settings@@anp-decoration-toggle": true,
  "anuppuccin-theme-settings@@anp-colorful-frame": true,
  "anuppuccin-theme-settings@@anp-colorful-frame-opacity": 1,
  "anuppuccin-theme-settings@@anp-collapse-folders": true,
  "anuppuccin-theme-settings@@anp-file-icons": true,
  "anuppuccin-theme-settings@@anp-file-label-align": "0",
  "anuppuccin-theme-settings@@anp-alt-rainbow-style": "anp-full-rainbow-color-toggle",
  "anuppuccin-theme-settings@@anp-rainbow-folder-bg-opacity": 0.9,
  "anuppuccin-theme-settings@@anp-simple-rainbow-title-toggle": true,
  "anuppuccin-theme-settings@@anp-simple-rainbow-indentation-toggle": true,
  "anuppuccin-theme-settings@@anp-alt-tab-style": "anp-safari-tab-toggle",
  "anuppuccin-theme-settings@@anp-depth-tab-opacity": 0.6,
  "anuppuccin-theme-settings@@anp-depth-tab-gap": 10,
  "anuppuccin-theme-settings@@anp-safari-tab-animated": true,
  "anuppuccin-theme-settings@@anp-layout-select": "anp-border-layout",
  "anuppuccin-theme-settings@@anuppuccin-theme-light": "ctp-rosepine-light",
  "anuppuccin-theme-settings@@anp-editor-font-rv": "SF Compact",
  "anuppuccin-theme-settings@@anp-toggle-preview": false
}
```

Centering rules for "**Titles**" and "**Images**"

```css title:.obsidian/snippets/main.css
.center-images img {
    display: block !important;
    margin-left: auto !important;
    margin-right: auto !important;
}

.no-embed-border {
    --embed-border-left: 0px solid black !important;
}

/* .markdown-preview-view */
.markdown-preview-view {
    border-radius: 6px;
}

.center-titles
:is(
    h1,
    h2,
    h3,
    h4,
    h5,
    h6,
    .HyperMD-header.HyperMD-header-1,
    .HyperMD-header.HyperMD-header-2,
    .HyperMD-header.HyperMD-header-3,
    .HyperMD-header.HyperMD-header-4,
    .HyperMD-header.HyperMD-header-5,
    .HyperMD-header.HyperMD-header-6
) {
    text-align: center;
}
```

Custom Callouts styles

```css title:.obsidian/snippets/custom-callouts.css
.callout[data-callout="note"] {
  --callout-color: 249, 249, 14;
  --callout-icon: lucide-align-left;
}

.callout[data-callout="anecdote"] {
  --callout-color: 192, 132, 252;
  --callout-icon: lucide-messages-square;
}

.callout[data-callout="insight"] {
  --callout-color: 251, 191, 36;
  --callout-icon: lucide-chart-network;
}

.callout[data-callout="advice"] {
  --callout-color: 55, 238, 182;
  --callout-icon: lucide-hand-heart;
}

.callout[data-callout="license-info"] {
  --callout-color: 28, 178, 242;
  --callout-icon: lucide-key-round;
}

.callout[data-callout="resource-links"] {
  --callout-color: 28, 178, 242;
  --callout-icon: lucide-qr-code;
}

.callout[data-callout="project-goals"] {
  --callout-color: 253, 124, 206;
  --callout-icon: lucide-target;
}

.callout[data-callout="project-links"] {
  --callout-color: 253, 124, 206;
  --callout-icon: lucide-link;
}

.callout[data-callout="references"] {
  --callout-color: 247, 130, 130;
  --callout-icon: lucide-newspaper;
}
```

Custom progress-bar styles

```css title:.obsidian/snippets/progress-bar.css
.progress-container {
  width: 100%;
  margin: 10px 0;
  text-align: center;
}

.progress {
  width: 100%;
  height: 12px;
  background: rgba(0, 0, 0, 0.1);
  border-radius: 4px;
  box-shadow:
    inset 0 1px 2px rgba(0, 0, 0, 0.25),
    0 1px rgba(255, 255, 255, 0.08);
  overflow: hidden;
  position: relative;
  padding: 0;
}

.progress-bar {
  height: 100%;
  width: 0%;
  background-color: #fcbc51;
  border-radius: 4px;
  transition: width 0.3s ease-in-out;
  position: absolute;
  top: 0;
  left: 0;
}

/* Optional: Reintroduce stripes */
.progress-bar::after {
  content: "";
  position: absolute;
  width: 100%;
  height: 100%;
  background-image: repeating-linear-gradient(
    45deg,
    rgb(252, 163, 17) 0px,
    rgb(252, 163, 17) 6px,
    transparent 6px,
    transparent 12px
  );
  opacity: 0.3;
}
```

