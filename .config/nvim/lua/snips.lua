local U = require'snippets.utils'

_global = {
  date = "${=os.date()}",
  todo = U.force_comment "TODO: ",
}

javascript = {
  cl = "console.log(${1})",
  func = "function(${1}) {${0}}",
  imp = "import ${1} from '${2}'",
}

html = {
  dj = "{% ${1} %}",
  djv = "{{ ${1} }}",
}

css = {
  media = U.match_indentation [[
@media (min-width: $1) {
$0
}
]],
  flexc = U.match_indentation [[
display: flex;
justify-content: center;
align-items: center;
]],
  flexb = U.match_indentation [[
display: flex;
justify-content: space-between;
align-items: center;
]],
  inset0 = U.match_indentation [[
top: 0;
bottom: 0;
left: 0;
right: 0;
]]
}

return {
  _global = _global,
  javascript = javascript,
  html = html,
  css = css,
}
