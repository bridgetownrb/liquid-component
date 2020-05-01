# Liquid Components
Smart components for the Liquid templating language

## Spec in progress

Working code is on its way, but meanwhile this is a quick attempt to document a possible spec for Liquid Components. It builds upon the brand new `render` tag functionality but adds block mode, Markdown formatting, and validation.

### Example

```liquid
{% rendercontent "cards/widget", title: "I'm a Card", show_footer: false, theme: page.theme %}
I'm the body of the card. I support **Markdown** _formatting!_
{% endrendercontent %}
```

### Defining a Component

```html
---
name: Widget Card
description: Displays a card about a widget that you can open.
variables:
  title:
    - string
    - The title of the card displayed in a header along the top.
  show_footer?: [boolean, Display bottom footer.]
  theme?: object
  content: markdown
---

<div class="widget card {{ theme | default: "default" }}">
  <div class="card-title">{{ title }}</div>
  <div class="card-body">{{ content }}</div>
  {% if show_footer %}
    <div class="card-footer"><button>Open the Widget</button></div>
  {% endif %}
</div>
```

### Variable Warnings

If a variable is supplied to a component in the wrong format, or if it's missing when it's required, then the component parser will emit a Liquid warning. By default it won't interrupt the overall rendering of Liquid templates (but that is configurable). The goal is simply to catch errors at development time, not frustrate the process of generating a working site.

## TODO

* Finish fleshing out variable types
* Describe content processors (HTML, Markdown, JSON, YAML, etc.)
* Investigate multiple "content areas" ([see github/view_component for inspiration](https://github.com/github/view_component/blob/master/README.md#content-areas))
* How to handle sidecar assets for components (related JS and CSS files)
  * _Interesting thought:_ what if each component rendered out as a Web Component (aka `<liquid-cards-widget>…</liquid-cards-widget>`) and then that could easily be hooked into for implementing CSS/JS frontend functionality? Maybe make that an optional `web_component: true` setting in the front matter.
* Testing strategy
* Component previews
