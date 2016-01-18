expand = (text)->
  text
    .replace /.[\b](.)/g, '$1'
    .replace /&/g, '&amp;'
    .replace /</g, '&lt;'
    .replace />/g, '&gt;'
    .replace /\n/g, '<br>'

emit = ($item, item) ->
  $item.append """
    <div style="background-color:#eee;padding:15px;">
      <p> #{expand item.text} <button style="float:right;">run</button> </p>
    </div>
  """



bind = ($item, item) ->
  $item.dblclick -> wiki.textEditor $item, item
  report = (reply) ->
    $item.find('div').append """
      <div class="reply" style="background-color:#fff; padding: 10px;">
        <pre style='font-size: 10px; word-wrap: break-word; color: #d00'>#{expand reply.stderr}</pre>
        <pre style='font-size: 10px; word-wrap: break-word;'>#{expand reply.stdout}</pre>
      </div>
    """
  $item.find('button').click ->
    $item.find('.reply').remove()
    $.post '/plugin/shell', item, report


window.plugins.shell = {emit, bind} if window?
module.exports = {expand} if module?

