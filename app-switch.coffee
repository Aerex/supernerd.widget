options =
  display: "applications" # applications | desktops

command: "echo $(./supernerd.widget/scripts/spaces.sh)"

refreshFrequency: 1000  

render: ( ) ->
  """
  <div class="container">
      <div class="widg">
        <div class="output cyan" id="mode">
          <div class="icon-container cyan" id="mode-icon-container">
             <i class="fab fa-apple" id="focus-icon"></i>
           </div>
        </div>
        <span class="output" id="spaces">
      </div>
      </div>

    </div>
  </div>

  """

getIcon: ( mode ) -> # No spaces, no numbers in the app name.
  icon = switch

    when /bsp/i.test(mode) then "fas fa-th"
    when /w/i.test(mode) then "fas fa-align-justify"
    when /float/i.test(mode) then "far fa-clone"
    else "far fa-window-maximize"
 
   return icon

update: ( output, domEl ) ->
  # my attempts to get monospaced spaces list:
  [mode, spaces, focused...] = output.split '|'
  console.log(mode)
  processIcon = @getIcon mode
  $("#mode-icon-container",el ).html("""
          <i class="#{ processIcon }" id="#{mode}-icon"></i>
    """)
  #spaces = @redraw spaces
   
  focused = @dotted focused.join('|'), 60
  output = ["<span>#{focused}</span>", "<span>| #{mode}<span>" ].join('')
  $("#spaces", el).html("  #{output}")

dotted: (str, limit) ->
  dots = "..."
  if str.length > limit
    str = str.substring(0,limit) + dots
  return str

redraw: (spaces) ->
  list = spaces.split ' '
  result = ( @decide space for space in list).join('')

decide: (elem) ->
  elem.replace /^\s+|\s+$/g, ""
  if elem is ""
    return """ """
  else
    if elem[0] is "("
      elem = elem[1...-1]
      elem = """<span class="list active">#{elem}</span>"""
    else
      elem = """<span class="list inactive">#{elem}</span>"""
    return elem

