# Liquid::Component
Smart components for the Liquid templating language

## Spec in progress

Working code is on its way, but meanwhile this is a quick attempt to document a possible spec for Liquid Components.

### Example

```liquid
{% component cards/widget title="I'm a Card" show_footer=false theme=page.theme %}
I'm the body of the card. I support **Markdown** _formatting!_
{% endcomponent %}
```

### Defining a Component

```html
---
name: Widget Card
description: Displays a card about a widget that you can open.
content_processor: markdown
props:
  -
    title: string
    show_footer?: boolean
    theme?: object
---

{%- assign theme = "default" -%}
{%- if props.theme -%}
  {%- assign theme = props.theme.cards -%}
{%- endif %}

<div class="widget card {{ theme }}">
  <div class="card-title">{{ props.title }}</div>
  <div class="card-body">{{ props.content }}</div>
  {% if props.show_footer %}
    <div class="card-footer"><button>Open the Widget</button></div>
  {% endif %}
</div>
```

### Prop Warnings

If a prop is supplied to a component in the wrong format, or if it's missing when it's required, then the component parser will emit a Liquid warning. By default it won't interrupt the overall rendering of Liquid templates (but that is configurable). The goal is simply to catch errors at development time, not frustrate the process of generating a working site.

## TODO

* Finish fleshing out prop types
* Describe content processors (HTML, Markdown, JSON, YAML, etc.)
* Investigate multiple "content areas" ([see github/view_component for inspiration](https://github.com/github/view_component/blob/master/README.md#content-areas))
* How to handle sidecar assets for components (related JS and CSS files)
