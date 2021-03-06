# Knockout Pickadate Binding

This binding adds a [pickadate.js datepicker](http://amsul.ca/pickadate.js) and
binds it to a knockout observable.

## Demo

Check out the [demo](http://rawgit.com/immense/knockout-pickadate/master/demo.html)
to get a quick idea of how it works and how to use it.

## Installation

The knockout-pickadate binding is available in the bower repository. To install
it in your bower enabled project, just do:

`bower install knockout-pickadate-binding`

## Usage

Include a link to the javascript and css files in your page:

```html
<input type='text' data-bind='pickadate: observable'>
```

And then refer to the [demo](http://rawgit.com/immense/knockout-pickadate/master/demo.html)
page on detailed usage instructions.

## Building

To build knockout-pickadate from the less and coffeescript source, do the
following in a node.js enabled environment:

```
npm install -g grunt-cli
npm install
grunt
```
## License

The knockout-pickadate binding is released under the MIT License. Please see the
LICENSE file for details.
