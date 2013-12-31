//!requires_package jquery

typeof jQuery != 'undefined' && (function ($, window, document, undefined) {

    $(function () {

        $('.list.accordion').on('click', 'a', function (event) {
            event.preventDefault();

            // Toggle slide animation and "active" class for sublist
            var $target = $(event.target).closest('li');
            $target.children('ul,ol').slideToggle('fast', function () {
                $target.toggleClass('active');
            });
        });

        $('.list.flyout')

        .on('mouseenter', 'li', function (event) {

            var $target = $(event.target);

            // Calculate child list position
            var position = $target.position();

            var x = Math.ceil(position.left);
            var width = $target.outerWidth();

            var y = Math.ceil(position.top);

            var paddingRight = $target.css('padding-right');
            paddingRight = parseInt(paddingRight.replace('px', ''), 8);

            // Base the width of the child list on the root list
            var $root = $target.closest('.flyout').children('ul,ol');
            var rootWidth = $root.outerWidth();

            // Display child list
            $target.siblings('ul,ol').css({
                'position': 'absolute',
                'left': x + width - paddingRight,
                'top': y,
                'width': rootWidth
            }).fadeIn();

        })

        .on('mouseleave', 'li', function (event) {
            $(event.target).siblings('ul,ol').fadeOut();
        });

    });

})(jQuery, window, document);