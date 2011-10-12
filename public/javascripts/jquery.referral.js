$.fn.referral = {
  
  defaults: {
    facebook: {
      appId: null,
      status: true, // check login status
      cookie: true, // enable cookies to allow the server to access the session
      xfbml: true, // parse XFBML
      channelUrl: '', // Custom channel URL
      oauth: true // enables OAuth 2.0
    } //facebook
  }, //defaults
  
  helpers: {
    facebook: {
      loaded: false
    }, //facebook
    twitter: {
      loaded: false
    }, //twitter
    loadedAPIs: function(){
      return $.fn.referral.helpers.facebook.loaded && $.fn.referral.helpers.twitter.loaded;
    }, //loadedAPIs
    callWhenIsLoaded: function(fn){
      var functions = typeof fn == 'function' ? [fn] : fn;
      
      var i = window.setInterval(function(){
        if($.fn.referral.helpers.loadedAPIs()){
          clearInterval(i);
          
          $(functions).each(function(){
            this.call();
          });
        }
      }, 500);
      
    }, //callWhenIsLoaded
    
    incrementVisit: function(){
      if(!$.cookie('_referral_visited')){
        $.ajax({
          url: '/referral/visit',
          type: 'post'
        })
        
        $.cookie('_referral_visited', 1)
      }
    },
    
    nothing: 1
  }, //helpers
  
  plugin: function(){
    var self = this;
    
    self.twitter = {
      add: function(){
        var script = document.createElement('script');
        script.type = 'text/javascript';
        script.onload = self.twitter.onLoad;
        script.src = 'http://platform.twitter.com/widgets.js';
        
        $("head")[0].appendChild(script);
      }, //add
      onLoad: function(){
        $.fn.referral.helpers.twitter.loaded = true;
      }, //onLoad
      track: function(){
        
      } //track
    }; //twitter
    
    self.facebook = {
      add: function(){
        $('body').prepend('<div id="fb-root"></div>');
        
        var script = document.createElement('script');
        script.type = 'text/javascript';
        script.onload = self.facebook.onLoad;
        script.src = 'http://connect.facebook.net/en_US/all.js';
        
        $("head")[0].appendChild(script);
      }, //add
      onLoad: function(){
        $.fn.referral.helpers.facebook.loaded = true;
      }, //onLoad
      init: function(){
        FB.init($.fn.referral.settings.facebook);
      }, //init
      track: function(){
        
      } //track
    } //facebook
    
    self.init = function(){
      $.fn.referral.helpers.callWhenIsLoaded(self.facebook.init);
      $.fn.referral.helpers.callWhenIsLoaded($.referral.events);
    } //init
    
  } //plugin
} //fn.referral

$.referral = {
  events: function(){
    $('._referral-facebook-share').live('click', $.referral.facebook.share);
    //$('._referral-twitter-tweet').live('click', $.referral.twitter.tweet);
    twttr.events.bind('tweet', $.referral.twitter.track)
  }, //events
  chart: {
		funnel: {
			draw: function(data, to){
				var chart = new Highcharts.Chart({
					chart: {		  
            backgroundColor: 'transparent',
						renderTo: to,
						defaultSeriesType: 'funnel',
						margin: [0, 0, 0, 30]
					},
					credits: {
						enabled: false
					},
					title: {
						text: ''
					},
					plotArea: {
						shadow: null,
						borderWidth: null,
						backgroundColor: null
					},
					tooltip: {
						formatter: function() {
							return '<b>'+ this.point.name +'</b>: '+ Highcharts.numberFormat(this.y, 0);
						}
					},
					plotOptions: {
						series: {
							dataLabels: {
								align: 'left',
								x: -220,
								enabled: true,
								formatter: function() {
									return '<b>'+ this.point.name +'</b> ('+ Highcharts.numberFormat(this.point.y, 0) +')';
								},
								color: 'black'
							},
            
							neckWidth: '0%',
							neckHeight: '0%'
						}
					},
					legend: {
						enabled: false
					},
					series: [{
						name: 'Conversão',
						data: data
					}]
				});
			} //draw
		} //funnel
	}, //chart
  facebook: {
    share: function(){
      var share = $(this);
      FB.ui({
        method: 'feed',
        display: 'popup',
        name: share.attr('data-name'),
        link: share.attr('data-link'),
        picture: share.attr('data-picture'),
        caption: share.attr('data-caption'),
        description: share.attr('data-description')
      }, function(response){ $.referral.facebook.track(response, share.attr('data-link')) }); //FB.ui
      
      return false;
    }, //
    track: function(response, link) {      
      if (response && response.post_id) {
        var url = '/share_urls/share'
      }
      else{
        var url = '/share_urls/not_share'
      }
      $.ajax({
        type: "PUT",
        data: { id_base62: link.split('l/')[1] },
        url: url
      });
    }, //track
    buildShareButton: function(options){
      return '<a \
        data-name="'+ options.name +'" \
        data-link="'+ options.link +'" \
        data-picture="'+ options.picture +'" \
        data-caption="'+ options.caption +'" \
        data-description="'+ options.description +'" \
      href="javascript:void(0)" class="_referral-facebook-share">'+ options.html +'</a>'
    }, //
    append: function(options){
      $.fn.referral.helpers.callWhenIsLoaded(function(){
        $(options.appendTo).append($.referral.facebook.buildShareButton(options));
      });
      
      $.fn.referral.helpers.incrementVisit();
    } //appendTo
  }, //facebook
  twitter: {
    tweet: function(){
      var share = $(this);
      
      var params = {
        url: encodeURI(share.attr('data-url')),
        via: encodeURI(share.attr('data-via')),
        text: encodeURI(share.attr('data-text'))
      };
      
      var width = 460;
      var height = 350;
      var left = parseInt((screen.availWidth/2) - (width/2));
      var top = parseInt((screen.availHeight/2) - (height/2));
      var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;
      window.open('http://twitter.com/share?'+ $.param(params), "tweet", windowFeatures);
      
      return false;
    }, //
    track: function(event){
      var url = '/share_urls/share'
      var self = $(event.target);
      var link = self.attr('data-url');
      
      $.ajax({
        type: "PUT",
        data: { id_base62: link.split('l/')[1] },
        url: url
      });
    }, //track
    buildTweetButton: function(options){
      return '<a href="https://twitter.com/intent/tweet?url='+ encodeURI(options.url) +'&via='+ encodeURI(options.via) +'&text='+ encodeURI(options.text) +'" data-url="'+ options.url +'" class="_referral-twitter-tweet">'+ options.html +'</a>'
    }, //
    append: function(options){
      $.fn.referral.helpers.callWhenIsLoaded(function(){
        $(options.appendTo).append($.referral.twitter.buildTweetButton(options));
      });
      
      //_referral.twitter.add();
      $.fn.referral.helpers.incrementVisit();
    } //appendTo
  }, //twitter
  init: function(options){
    $.fn.referral.settings = $.extend( true, $.fn.referral.defaults, options );
    
    window['_referral'] = new $.fn.referral.plugin();
    
    $(function(){
      _referral.facebook.add();
      _referral.twitter.add();
      
      _referral.init();
    }); 
  }, //init
  
  nothing: 1
}; //referral

/**
* jQuery Cookie plugin
*
* Copyright (c) 2010 Klaus Hartl (stilbuero.de)
* Dual licensed under the MIT and GPL licenses:
* http://www.opensource.org/licenses/mit-license.php
* http://www.gnu.org/licenses/gpl.html
*
*/
jQuery.cookie = function (key, value, options) {

    // key and at least value given, set cookie...
    if (arguments.length > 1 && String(value) !== "[object Object]") {
        options = jQuery.extend({}, options);

        if (value === null || value === undefined) {
            options.expires = -1;
        }

        if (typeof options.expires === 'number') {
            var days = options.expires, t = options.expires = new Date();
            t.setDate(t.getDate() + days);
        }

        value = String(value);

        return (document.cookie = [
            encodeURIComponent(key), '=',
            options.raw ? value : encodeURIComponent(value),
            options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
            options.path ? '; path=' + options.path : '',
            options.domain ? '; domain=' + options.domain : '',
            options.secure ? '; secure' : ''
        ].join(''));
    }

    // key and possibly options given, get cookie...
    options = value || {};
    var result, decode = options.raw ? function (s) { return s; } : decodeURIComponent;
    return (result = new RegExp('(?:^|; )' + encodeURIComponent(key) + '=([^;]*)').exec(document.cookie)) ? decode(result[1]) : null;
};


