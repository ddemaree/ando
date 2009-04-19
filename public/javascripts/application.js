// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

Ando = Class.create()
Ando.InlineEditor = Class.create({
	initialize: function(id,options){
		this.options = {
      previewTextIfBlank:  "Click to edit",
			previewTag:   "p",
			previewClass: "fieldPreview"
    };
		Object.extend(this.options, options || { });
		
		this.container = $(id)
		this.container.addClassName('ando-inline-editor');
		
		this.container.insert({
			top:new Element(this.options.previewTag, {
				className:this.options.previewClass
			})
		});
		
		this.preview = this.container.down("." + this.options.previewClass)
		// console.log(this.preview.getHeight())
		// 		
		// 		this.previewHoverOutline = new Element('div', {className: 'previewOutline'})
		// 		this.previewHoverOutline.setStyle({
		// 			position: 'absolute',
		// 			top:    (this.container.positionedOffset().top - 5) + 'px',
		// 			left:   (this.container.positionedOffset().left - 5) + 'px',
		// 			border: "2px solid #000",
		// 			height: (this.container.getHeight() + 10) + "px",
		// 			width:  "400px",
		// 			zIndex: 400
		// 		})
		// 		this.previewHoverOutline.setStyle("-webkit-border-radius:6px")
		// 		
		// 		this.container.insert({top:this.previewHoverOutline})
		// 		console.log(this.previewHoverOutline)
		
		this.field = this.container.down('.field,input,textarea')
		this.fieldWrapper = this.field.wrap(new Element('div', {className: 'fieldWrapper', style:'display:none'}))
		
		// Remove label element from DOM
		this.container.down('label').remove()
		
		this.updatePreview()
		
		// Setup observers
		this.preview.observe('click', this.beginEditing.bind(this))
		this.preview.observe('mouseover', this.onMouseOver.bind(this))
		this.preview.observe('mouseout',  this.onMouseOut.bind(this))
		this.field.observe('keypress', this.onKeyPress.bind(this))
		this.field.observe('blur', this.onBlur.bind(this))
		
		this.originalColor = this.preview.getStyle("color");
		
	},
	updatePreview: function(){
		if($F(this.field).blank()){
			this.preview.update(this.options.previewTextIfBlank)
			this.preview.addClassName('blank');
		}
		else {
			this.preview.update($F(this.field))
			this.preview.removeClassName('blank')
		}
	},
	beginEditing: function(){
		this.toggle()
		this.field.focus()
	},
	endEditing: function(){
		this.updatePreview()
		this.toggle()
	},
	toggle: function(){
		this.preview.toggle()
		this.fieldWrapper.toggle()
	},
	onMouseOver: function(){
		$$('.fieldPreview').invoke('removeClassName','hover');
		this.preview.addClassName('hover');
	},
	onMouseOut: function(){
		this.preview.removeClassName('hover');
	},
	onKeyPress: function(event){
		if(event.keyCode == Event.KEY_RETURN){
			event.stop()
			this.endEditing()
		}
	},
	onBlur: function(){
		this.endEditing()
	}
})

SelfLabel = {
	create: function(field){
		Object.extend(field,{
			setup: function(){
				this.observe('blur', this.handleBlur)
				this.observe('focus', this.handleFocus)
				this.handleBlur()
			},
			handleBlur: function(){
				if(this.value == ''){
					$(this).addClassName('blank')
					this.value = this.getAttribute('selflabel')
				}
			},
			handleFocus: function(){
				if (this.value == this.getAttribute('selflabel')) { $(this).removeClassName('blank'); this.value=''; };
			}
		})
		
		field.setup()
	}
}

Event.observe(window, 'load', function(){
	$$('input[selflabel]').each(function(field){

		SelfLabel.create(field);

		field.setup()
	});
	
	$$('label.sl').each(function(label){
		if(label.getAttribute('for')){
			field = $(label.getAttribute('for'));
			field.writeAttribute('selflabel', label.innerHTML);
			SelfLabel.create(field);
			label.hide()
		}	
	});
})