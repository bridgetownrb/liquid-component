**THIS IS NO LONGER BEING MAINTAINED and has been archived.**

----

# Liquid Component

Smart components for the Liquid template language. Use YAML front matter to specify component metadata (name, description) and variable types. Use
component metadata for validation and reflection (perhaps to build visual preview stories).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'liquid-component'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install liquid-component
```

## Usage

Given a Liquid template string, all you need to do is call `LiquidComponent.parse`:

```ruby
component = LiquidComponent.parse(template)
```

The return value will be a `LiquidComponent::Component` object which provides two data structures:

* `metadata`: the parsed front matter as a `LiquidComponent::Metadata` object.
* `content`: the body of the Liquid template.

Even if there's no front matter, a component will successfully instantiate, but all the metadata values will be nil. The component object also provides convenience methods to get to the metadata values, so `component.name` is the same as `component.metadata.name`.

Here are the possible `LiquidComponent::Metadata` values, all optional:

* `name`: the human-readable name of the component.
* `description`: a description of what the component is for.
* `variables`: an array of `LiquidComponent::Variable` variable definitions.
* `additional`: any additional custom YAML front matter, if any.

Here are the possible `LiquidComponent::Variable` values:

* `name`: the variable identifier.
* `type`: a symbol indicating a data type…string, boolean, array, etc.
* `required`: `true` if the variable is required, `false` if it is optional.
* `description`: an optional description of what the variable is for.

## Spec in progress

This is a quick attempt to document a possible spec for Liquid Components. It builds upon the brand new `render` tag functionality but adds block mode, Markdown formatting, and validation.

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
  show_footer: [boolean, Display bottom footer.]
  theme?: object # optional variable
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

### Variable Warnings (TODO)

If a variable is supplied to a component in the wrong format, or if it's missing when it's required, then the component will emit a Liquid warning. By default it won't interrupt the overall rendering of Liquid templates (but that is configurable). The goal is simply to catch errors at development time, not frustrate the process of generating a working site.

## TODO

* Finish fleshing out variable types
* Variable validation
* Describe content processors (HTML, Markdown, JSON, YAML, etc.)
* Investigate multiple "content areas" ([see github/view_component for inspiration](https://github.com/github/view_component/blob/master/README.md#content-areas))
* How to handle sidecar assets for components (related JS and CSS files)
  * _Interesting thought:_ what if each component rendered out as a Web Component (aka `<liquid-cards-widget>…</liquid-cards-widget>`) and then that could easily be hooked into for implementing CSS/JS frontend functionality? Maybe make that an optional `web_component: true` setting in the front matter.
  * _An additional (optional) possibility:_ variable data serialized to JSON in attributes. So `<liquid-product-header name="My Product" details='{"price": 3024}'>…html…</liquid-product-header>`, where `name` and `details` are variables passed to the Liquid template itself. Why would we want to do this? So a library such as `lit-element` could easily hydrate a Liquid Component and use the JSON data as props for further tweaking at runtime.
* Testing strategy
* Component previews

----

## Testing

Run `bundle exec rake` to run the test suite.

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bridgetownrb/liquid-component.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Liquid Component project’s codebases, issue trackers, and discussion forums is expected to follow the [code of conduct](https://github.com/bridgetownrb/liquid-component/blob/master/CODE_OF_CONDUCT.md).
