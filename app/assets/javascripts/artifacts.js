var ready;
ready = function() {
	$('.art-cards').hover( 
		function(){
			$(this).find('.meta-options').css('display', 'inline');
		},
		function(){
			$(this).find('.meta-options').css('display', 'none');
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

};

$(document).ready(ready);
$(document).on('page:load', ready);

