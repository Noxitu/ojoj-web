
$(document).on('ready page:load', function () {
	$('.group-user-row').click( function() {
        console.log('a');
        var e = $(this).find('input')[0];
        e.checked = !e.checked;
        $(this).closest('.group-user-row').toggleClass('checked', e.checked);
    });
    
    $('.group-user-row input').change( function() {
        $(this).closest('.group-user-row').toggleClass('checked', this.checked);
    }).hide();
});