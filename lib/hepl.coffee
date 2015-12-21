{CompositeDisposable} = require 'atom'

module.exports = Hepl =
  subscriptions: null

  activate: ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'hepl:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()

  toggle: ->
    if editor = atom.workspace.getActiveTextEditor()
      @word = editor.getSelectedText()
      if @word != ''
        if @word.length > 20
          @more = '…'
        else
          @more = ''
        @conf = confirm( 'Remplacer ' + @word.substring(0,20) + @more + ' par HeplHe…?' )
        if @conf
          @change = "Hepl"
          @i = 0
          @j = 0
          @output = ""

          while @i <= @word.length - 1
            @output += @change.charAt( @j )
            @j++
            if @j > @change.length - 1
              @j = 0
            @i++


          editor.insertText( @output )
      else
        alert( 'Veuillez sélectionner du texte' )
