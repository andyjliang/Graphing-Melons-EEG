/**
 * @author anliang
 */
$(function(){
	
	function ButtonViewModel(){
		var self = this;
		self.toggleBackground = function(){
			$('header').css({
				'background-image': 'none',
				'display': 'none'
			});
			$('.content').css({
				'background-color': '#281B57',
				'display': 'inline-block'
			})
		}
	}
	
	function GraphViewModel(){
		var self = this;
		self.ballShiftL = 0;
		self.pulseShiftL = 0;
		self.lineShiftL = 0;
		self.stepWidth = 100;
		self.points = ko.observableArray([
			{y: 10, tooltip: 'one'},
			{y: 110, tooltip: 'two'},
			{y: 210, tooltip: 'three'},
			{y: 210, tooltip: 'four'},
			{y: 110, tooltip: 'five'},
			{y: 10, tooltip: 'six'},
			{y: 190, tooltip: 'seven'},
			{y: 20, tooltip: 'eight'},
			{y: 80, tooltip: 'nine'},
			{y: 140, tooltip: 'ten'},
			{y: 30, tooltip: 'eleven'},
			{y: 95, tooltip: 'twelve'}
		]);
		
		self.angle = function(yInd){
			if (yInd +1 == this.points().length) return 0;
			var h = this.points()[yInd+1].y - this.points()[yInd].y;
			self.setKeyFrameMoveLength(h, yInd);
			var r = -(Math.atan(h/self.stepWidth)* (180/Math.PI));
			return 'rotate(' + r + 'deg)';
		}
		
		self.setKeyFrameMoveLength = function(h, yInd){
			var hyp = Math.sqrt(h*h+10000);
			var rule = "@-webkit-keyframes move" + yInd + " {0% { width:0px;} 100% { width:" + hyp + "px; box-shadow:0px 0px 5px 1px rgba(0,198,255,0.5); }}"
			var rule2 = "@-moz-keyframes move" + yInd + " {0% { width:0px;} 100% { width:" + hyp + "px; box-shadow:0px 0px 5px 1px rgba(0,198,255,0.5); }}"
			if(navigator.userAgent.indexOf("MSIE") > -1) document.styleSheets[0].insertRule(rule, 0);
			if(navigator.userAgent.indexOf("Mozilla") > -1) document.styleSheets[0].insertRule(rule2, 0);
		}
		
		self.leftShiftInc = function(el){
			var returnEl; 
			switch(el.className){
				case 'ball':
					self.ballShiftL += self.stepWidth;
					returnEl = self.ballShiftL - 5;
					break;
				case 'pulse':
					self.pulseShiftL += self.stepWidth;
					returnEl = self.pulseShiftL -7;
					break;
				case 'line':
					self.lineShiftL += self.stepWidth;
					returnEl = self.lineShiftL;
					break;	
				default: 
					break;
			}
			return returnEl + 'px';
		}
		
		self.bottomShiftInc = function(el, bottomShift){
			var returnEl; 
			switch(el.className){
				case 'ball':
					returnEl = bottomShift - 5;
					break;
				case 'pulse':
					returnEl = bottomShift -7;
					break;
				case 'line':
					returnEl = bottomShift;
					break;	
				default: 
					break;
			}
			return returnEl + 'px';
		}
		
		// self.someFunc = function(){
			// document.styleSheets[0].insertRule('@-moz-keyframes {\
			    // 0%   {width:0px;}\
			    // 100% {width:150px; box-shadow:0px 0px 5px 1px rgba(0,198,255,0.5);}\
			// }',1);
		// }

		self.myFunc = function(){
			// document.styleSheets[0].cssRules[9].appendRule("0% { width:0px;}");
			// document.styleSheets[0].cssRules[9].appendRule("100% { width:100px; box-shadow:0px 0px 5px 1px rgba(0,198,255,0.5);}");
			// document.styleSheets[0].insertRule(".line {transform: rotate(-40deg);}",3);
			var k = 0; 
		}
	}
	
	
	$(document).ready(function() {
		ko.applyBindings(new ButtonViewModel(), document.getElementById('graphButton'));
		ko.applyBindings(new GraphViewModel(), $('#graph')[0]);
	});
	
});