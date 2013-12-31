//!requires_package jquery

typeof jQuery != 'undefined' && (function ($, window, document, undefined) {

    $(document).addBlocksMethod('overflowScrollable',function(command){

      var commands = {

        'init': function(){

          var $this = $(this)

          if(!$this.parent().hasClass('overflow-scroll'))
            $this.wrap($(document.createElement('div')).addClass('overflow-scroll'))

        }

      }

      commands[command] && commands[command].call($(this), Array.prototype.slice.call(arguments,1));

    });

})(jQuery, window, document);
