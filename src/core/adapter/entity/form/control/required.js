$(document).addBlocksMethod('requiredFormControls', function(command){

    var addAriaAlert = function(){
        $(this).attr('role', $(this).hasClass('required') ? 'alert' : null);
    };

    var commands = {

        'init': function(){

            $(this).find('.control[data-required="true"]').each(function(){

                var $control = $(this),
                    $inputs = $control.find('input,textarea,select'),
                    markControls = function(){
                        if($inputs.filter(function(){ return !$(this).val().length }).length > 0){
                            $control.addClass('required');
                        }else{
                            $control.removeClass('required');
                        }
                    }

                if(!$control.closest('form.form').length)
                    return;

                $inputs.change(function(){
                    markControls();
                    addAriaAlert.call($control);
                })

                markControls()

                $control.find('.required-pass, .required-fail').attr('data-required', 'ready')

            })

            $(this).submit(function(e){
                $(this).blocks().requiredFormControls('validate').length || e.preventDefault();
            })

            return true;

        },

        'validate': function(){

            var $form = $(this),
                        $controls = $form.find('.control').filter(function(){ return $(this).hasClass('required') }),
                        $formRequiredFail = $form.find('.form-required-fail');

            if(!$controls.length)
                return $form;

            $controls.each(function(){
                addAriaAlert.call(this);
            })

            $form.addClass('form-required-failure');
            $formRequiredFail.attr('role', 'alert');
            return false;
        }

    };

    return $(this).map(function(){ return commands[command].apply(this)}).filter(function(){ return this.valueOf(); })


})

$(window).load(function(){
    $('form.form').blocks().requiredFormControls('init');
});
