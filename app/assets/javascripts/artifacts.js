var ready;
ready = function() {
	$('.art-cards').hover( 


		function(){

			$(this).find('.meta-options').css('display', 'inline');
		},


		function(){

			$(this).find('.meta-options').css('display', 'none');

		});
};

$(document).ready(ready);
$(document).on('page:load', ready);