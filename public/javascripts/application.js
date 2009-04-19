// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var Practical = {}

Object.extend(Practical, {
	GhostLabel: Class.create({
		initialize: function(id){
			this.wrapper = $(id)
			this.wrapper.makePositioned()

			this.field = this.wrapper.down('input, textarea')
			this.label = this.wrapper.down('label, .label')

			this.label.addClassName('ghost')
			this.label.setStyle("position:absolute;top:0;left:0;z-index:22;")

			this.label.observe('click', this.handleLabelClick.bind(this))
			this.field.observe('blur', this.handleFieldBlur.bind(this))
			this.field.observe('focus', this.handleFieldFocus.bind(this))
			
			if(!$F(this.field).blank())
				this.label.hide()
		},
		handleFieldFocus: function(event){
			this.label.hide()
		},
		handleLabelClick: function(event){
			console.log("Clicky click")
			this.field.focus()
			this.label.hide()
			event.stop()
		},
		handleFieldBlur: function(event){
			if($F(this.field).blank()){
				console.log("BLURRY")
				this.label.show()
			}
		}
	})
})


/* ANCHOR OBSERVER */

Practical.AnchorObserver = {
	enabled: true,
	interval: 0.1
}

document.observe("dom:loaded", function() {
  var lastAnchor = "";

  function poll() {
    var anchor = (window.location.hash || "").slice(1);
    if (anchor != lastAnchor) {
      document.fire("anchor:changed", { to: anchor, from: lastAnchor });
      lastAnchor = anchor;
    	console.log(anchor)
		}
  }

  if (Practical.AnchorObserver.enabled) {
    setInterval(poll, Practical.AnchorObserver.interval * 1000);
  }
});