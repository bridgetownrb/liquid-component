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
