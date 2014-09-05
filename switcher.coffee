#get reference to link tag
style = $ "#styles"

#get button references
blackButton = $ "#blackButton"
blueButton = $ "#whiteButton"

blackButton.click ->
  changeStyle "style1.css"

blueButton.click ->
  changeStyle "style2.css"

changeStyle = (stylesheet) ->
  style.attr href: stylesheet
  setCookie stylesheet

setCookie = (stylesheet) ->
  $.cookie 'style', stylesheet, { expires: 7}

$ ->
  stylesheet = $.cookie 'style'
  if stylesheet
    changeStyle stylesheet
    console.log stylesheet
  else
    changeStyle 'style1.css'

