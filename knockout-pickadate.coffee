pickadate_defaults =
  # Strings
  monthsFull: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
  monthsShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
  weekdaysFull: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
  weekdaysShort: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
  showMonthsShort: undefined
  showWeekdaysFull: undefined

  # Buttons
  today: 'Today'
  clear: 'Clear'

  # Accessibility Labels
  labelMonthNext: 'Next month'
  labelMonthPrev: 'Previous month'
  labelMonthSelect: 'Select a month'
  labelYearSelect: 'Select a year'

  # Formats
  format: 'd mmmm, yyyy'
  formatSubmit: undefined
  hiddenPrefix: undefined
  hiddenSuffix: '_submit'
  hiddenName: undefined

  # Editable input
  editable: undefined

  # Dropdown selectors
  selectYears: undefined
  selectMonths: undefined

  # First day of the week
  firstDay: undefined

  # Date limits
  min: undefined
  max: undefined

  # Disable dates
  disable: undefined

  # Root container
  container: undefined

  # Events
  onStart: undefined
  onRender: undefined
  onOpen: undefined
  onClose: undefined
  onSet: undefined
  onStop: undefined

  # Classes
  klass: {

      # The element states
      input: 'picker__input'
      active: 'picker__input--active'

      # The root picker and states *
      picker: 'picker'
      opened: 'picker--opened'
      focused: 'picker--focused'

      # The picker holder
      holder: 'picker__holder'

      # The picker frame, wrapper, and box
      frame: 'picker__frame'
      wrap: 'picker__wrap'
      box: 'picker__box'

      # The picker header
      header: 'picker__header'

      # Month navigation
      navPrev: 'picker__nav--prev'
      navNext: 'picker__nav--next'
      navDisabled: 'picker__nav--disabled'

      # Month & year labels
      month: 'picker__month'
      year: 'picker__year'

      # Month & year dropdowns
      selectMonth: 'picker__select--month'
      selectYear: 'picker__select--year'

      # Table of dates
      table: 'picker__table'

      # Weekday labels
      weekdays: 'picker__weekday'

      # Day states
      day: 'picker__day'
      disabled: 'picker__day--disabled'
      selected: 'picker__day--selected'
      highlighted: 'picker__day--highlighted'
      now: 'picker__day--today'
      infocus: 'picker__day--infocus'
      outfocus: 'picker__day--outfocus'

      # The picker footer
      footer: 'picker__footer'

      # Today & clear buttons
      buttonClear: 'picker__button--clear'
      buttonToday: 'picker__button--today'
  }

ko.bindingHandlers.pickadate =
  init: (element, valueAccessor, allBindings) ->
    value = valueAccessor()
    options = pickadate_defaults

    pickadate_options = allBindings.get('pickadate_options')

    _init_picker = ($elem) ->
      return $elem
        .attr 'autocomplete', 'off'
        .pickadate options
        .pickadate 'picker'

    if 'function' is typeof pickadate_options
      options_from_binding = pickadate_options()
    else
      options_from_binding = pickadate_options or {}

    for key, val of options_from_binding
      options[key] = val

    if options.calendar_addon
      wrapper_id = new Date().getTime()
      options.container = "##{wrapper_id}"

      $calendar_addon = $(
        "<span class='input-group-addon'>" +
          "<i style='color: navy; cursor: pointer'" +
            "title='A calendar appears when interacting with this field'" +
            "class='fa fa-calendar'>" +
          "</i>" +
        "</span>"
      )

      picker = _init_picker(
        $(element)
          .wrap $("<div id=#{wrapper_id}></div>")
          .wrap $("<div class='input-group'></div>")
          .after $calendar_addon
      )

      $calendar_addon.on "click", (event) ->
        picker.open()
        event.stopPropagation()
        event.preventDefault()
    else
      picker = _init_picker $(element)

    picker.on 'set', (context) ->
      item = picker.get('select')
      if item
        if options.update_as_date
          # if item has been updated
          if item.obj.toString() isnt value()?.toString()
            value item.obj
        else
          if item isnt value()
            value picker.get()
      else
        value item

    ko.utils.domNodeDisposal.addDisposeCallback element, ->
      if options.calendar_addon
        $calendar_addon.off 'click'
      picker.stop() if picker.get('start')

    return

  update: (element, valueAccessor, allBindings) ->
    value   = valueAccessor()
    new_val = ko.unwrap value
    picker  = $(element).pickadate('picker')

    # observable updated with a blank date means we empty the input
    if not new_val? or new_val is ''
      picker.set('clear')
      return

    date = Date.parse(new_val)

    return if date is picker.get('select')?.pick

    # Try setting picker to whatever was passed in
    #
    # Pickadate seems to convert anything it can't handle (e.g. errors, NaN) to today's date
    # TODO: Maybe there's something more sensible than that?
    picker.set 'select', date

    return
