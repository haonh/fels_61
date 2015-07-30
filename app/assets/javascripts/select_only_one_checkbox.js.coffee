$('input[type=checkbox]').click ->
  $('input[type="checkbox"]').not(this).prop 'checked', false
  return
