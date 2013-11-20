if($.fn.ariaMapper)
    $(document).addBlocksMethod('ariaMapper',function(options){

            // Default options
        var defaults = {
                "roles": {
                    "selectors": {
                        "alert": [
                            ".message.error",
                            ".message.danger",
                            ".message.important",
                            ".message.required"
                        ],
                        "search": [ "nav.search" ],
                        "status": [
                            ".message.highlight",
                            ".message.success",
                            ".message.warning",
                            ".message.info"
                        ]
                    },
                    "filters": {
                        "navigation": function(){ return !this.hasClass('search') }
                    },
                    "callbacks": {
                    },
                    "exclusions": []
                },
                "labeledby": {
                    "selectors": {
                        "form.form div.control label input": function(){
                            var label = this.closest('div.control').children('label').first();
                            if(label.find('input').length == 0)
                                this.ariaMapperHelper('setLabeledBy', label)
                        }
                    }
                }
            };

        $(this).ariaMapper($.extend( true, {}, defaults, options));

    });