
var interval = 10;
var interval_index_multiplayer = 4;

$(document).on('ready page:load', function () {
  ignoreIntervalTics = interval_index_multiplayer-1;
});

function ajax_data(data) {
	for( var i = 0; i < data.length; i++ ) {
		var id = data[i][0];
		var e = $('[data-subid="'+id+'"]');
		if( e.length > 0 ) 
			e.replaceWith(data[i][1]);
		else {
			var q = $('.ajax_submissions');
			if( q.length == 1 && !q[0].dataset.id ) {
				$('[data-subid]').first().before(data[i][1]);
			}
		}
	}
}

var ignoreIntervalTics = 0;
setInterval( function() {
	$('.ajax_submissions').each( function() {
		if( this.dataset.id ) {
			if( $(this).find('[data-subid]').is('[data-waiting]') )
				$.getJSON('/subs/ajax/'+this.dataset.since+'/'+this.dataset.id, ajax_data );
		} else if( ignoreIntervalTics == 0 ) {
			$.getJSON('/subs/ajax/'+this.dataset.since, ajax_data );
			ignoreIntervalTics = interval_index_multiplayer-1;
		}
	} );
	
	if( ignoreIntervalTics > 0 )
		ignoreIntervalTics--;
		
}, interval*1000 );

//= require syntax_highlighting.js