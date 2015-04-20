var ready;
ready = function() {
	$('.art-cards').hover( 
		function(){
			$(this).find('.meta-options').css('display', 'inline');
			$(this).find('.read-length').css('display', 'none');
		},
		function(){
			$(this).find('.meta-options').css('display', 'none');
			$(this).find('.read-length').css('display', 'inline');
		});

	if ($('.pagination').length){
		$(window).scroll(function(){
			url = $('.pagination .next_page').attr('href');
		if (url && ($(window).scrollTop() > $(document).height() - $(window).height() - 50)){
			$('.pagination').html('Getting more artifacts...');
			$.getScript(url);
		}
		});
	}

	// scrolling up

    $(function(){
      //Keep track of last scroll
      var lastScroll = 0;
      $(window).scroll(function(event){
          //Sets the current scroll position
          var st = $(this).scrollTop();
          //Determines up-or-down scrolling
          if (st > lastScroll){
             //Replace this with your function call for downward-scrolling
             $('.navbar.navbar-inverse').css('display', 'none');
          }
          else {
             //Replace this with your function call for upward-scrolling
             $('.navbar.navbar-inverse').css('display', 'inline');
          }
          //Updates scroll position
          lastScroll = st;
      });
    });



};

$(document).ready(ready);
$(document).on('page:load', ready);

