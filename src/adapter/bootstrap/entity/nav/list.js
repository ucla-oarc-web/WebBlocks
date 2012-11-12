$(function () {

    $('.list.accordion').on('click', 'a', function (event) {
        event.preventDefault();

        // Toggle slide animation and "active" class for sublist
        var $target = $(event.target).closest('li');
        $target.children('ul,ol').slideToggle('fast', function () {
            $target.toggleClass('active');
        });
    });

});