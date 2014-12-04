(function() {
  var pickadate_defaults;

  pickadate_defaults = {
    monthsFull: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
    monthsShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
    weekdaysFull: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
    weekdaysShort: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
    showMonthsShort: void 0,
    showWeekdaysFull: void 0,
    today: 'Today',
    clear: 'Clear',
    labelMonthNext: 'Next month',
    labelMonthPrev: 'Previous month',
    labelMonthSelect: 'Select a month',
    labelYearSelect: 'Select a year',
    format: 'd mmmm, yyyy',
    formatSubmit: void 0,
    hiddenPrefix: void 0,
    hiddenSuffix: '_submit',
    hiddenName: void 0,
    editable: void 0,
    selectYears: void 0,
    selectMonths: void 0,
    firstDay: void 0,
    min: void 0,
    max: void 0,
    disable: void 0,
    container: void 0,
    onStart: void 0,
    onRender: void 0,
    onOpen: void 0,
    onClose: void 0,
    onSet: void 0,
    onStop: void 0,
    klass: {
      input: 'picker__input',
      active: 'picker__input--active',
      picker: 'picker',
      opened: 'picker--opened',
      focused: 'picker--focused',
      holder: 'picker__holder',
      frame: 'picker__frame',
      wrap: 'picker__wrap',
      box: 'picker__box',
      header: 'picker__header',
      navPrev: 'picker__nav--prev',
      navNext: 'picker__nav--next',
      navDisabled: 'picker__nav--disabled',
      month: 'picker__month',
      year: 'picker__year',
      selectMonth: 'picker__select--month',
      selectYear: 'picker__select--year',
      table: 'picker__table',
      weekdays: 'picker__weekday',
      day: 'picker__day',
      disabled: 'picker__day--disabled',
      selected: 'picker__day--selected',
      highlighted: 'picker__day--highlighted',
      now: 'picker__day--today',
      infocus: 'picker__day--infocus',
      outfocus: 'picker__day--outfocus',
      footer: 'picker__footer',
      buttonClear: 'picker__button--clear',
      buttonToday: 'picker__button--today'
    }
  };

  ko.bindingHandlers.pickadate = {
    init: function(element, valueAccessor, allBindings) {
      var $calendar_addon, key, options, options_from_binding, pickadate_options, picker, val, value, wrapper_id, _init_picker;
      value = valueAccessor();
      options = pickadate_defaults;
      pickadate_options = allBindings.get('pickadate_options');
      _init_picker = function($elem) {
        return $elem.attr('autocomplete', 'off').pickadate(options).pickadate('picker');
      };
      if ('function' === typeof pickadate_options) {
        options_from_binding = pickadate_options();
      } else {
        options_from_binding = pickadate_options || {};
      }
      for (key in options_from_binding) {
        val = options_from_binding[key];
        options[key] = val;
      }
      if (options.calendar_addon) {
        wrapper_id = new Date().getTime();
        options.container = "#" + wrapper_id;
        $calendar_addon = $("<span class='input-group-addon'>" + "<i style='color: navy; cursor: pointer'" + "title='A calendar appears when interacting with this field'" + "class='fa fa-calendar'>" + "</i>" + "</span>");
        picker = _init_picker($(element).wrap($("<div id=" + wrapper_id + "></div>")).wrap($("<div class='input-group'></div>")).after($calendar_addon));
        $calendar_addon.on("click", function(event) {
          picker.open();
          event.stopPropagation();
          return event.preventDefault();
        });
      } else {
        picker = _init_picker($(element));
      }
      picker.on('set', function(context) {
        var item, _ref;
        item = picker.get('select');
        if (item) {
          if (options.update_as_date) {
            if (item.obj.toString() !== ((_ref = value()) != null ? _ref.toString() : void 0)) {
              return value(item.obj);
            }
          } else {
            if (item !== value()) {
              return value(picker.get());
            }
          }
        } else {
          return value(item);
        }
      });
      ko.utils.domNodeDisposal.addDisposeCallback(element, function() {
        if (options.calendar_addon) {
          $calendar_addon.off('click');
        }
        if (picker.get('start')) {
          return picker.stop();
        }
      });
    },
    update: function(element, valueAccessor, allBindings) {
      var date, new_val, picker, value, _ref;
      value = valueAccessor();
      new_val = ko.unwrap(value);
      picker = $(element).pickadate('picker');
      if ((new_val == null) || new_val === '') {
        picker.set('clear');
        return;
      }
      date = Date.parse(new_val);
      if (date === ((_ref = picker.get('select')) != null ? _ref.pick : void 0)) {
        return;
      }
      picker.set('select', date);
    }
  };

}).call(this);
