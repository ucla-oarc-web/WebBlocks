//!requires_package lettering

$(document).ready(function(){
    
    if(!jQuery().lettering)
        return;
    
    var linesClass = 'text-split-lines',
        wordsClass = 'text-split-words',
        charsClass = 'text-split-chars'

    $('.'+linesClass).each(function(){

        var $this = $(this)

        $this.lettering('lines')

        if($this.hasClass(wordsClass))
            $this.removeClass(wordsClass).children('span').addClass(wordsClass)

        if($this.hasClass(charsClass))
            $this.removeClass(charsClass).children('span').addClass(charsClass)

    })

    $('.'+wordsClass).each(function(){

        var $this = $(this)

        $this.lettering('words')

        if($this.hasClass(charsClass))
            $this.removeClass(charsClass).children('span').addClass(charsClass)

    })

    $('.'+charsClass).lettering()

});