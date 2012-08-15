This adapter defines all mixins used by the core definitions found in 
`/src/core/definitions`. In most cases, the mixins defined within this adapter
are empty, although it does define some basic mixins that are unlikely to change
between adapters.

This adapter thus has two purposes:

* Ensure that all mixins used by `/src/core/definitions` are defined to avoid compile errors
* Serve as a template to create adapters for `/src/adapter`.
* Avoid requiring each adapter to define basic mixins that are unlikely to change between adapters.

When creating a new adapter, it is recommended that this adapter be copied into
a new directory within `/src/adapter` and then modifications are applied as 
needed. This custom adapter may then be set within `/Rakefile-config.rb` by
defining `WebBlocks.config[:src][:adapter]`, referring to the directory name
within `/src/adapter`.

Because this adapter is always loaded *before* the adapter specified via the
configuration setting `WebBlocks.config[:src][:adapter]`, any mixins redefined 
within the adapter under `/src/adapter` will override the mixins defined in
this base adapter. However, this base set of definitions prevents the need to
define trivial mixins that are unlikey to change between different adapters
(like text alignment and block floats).