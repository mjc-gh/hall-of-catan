function add_player(e){
	var selects = $('select[name="game[player_ids][]"]');
	var link = $(e);

	var first = selects.eq(0);
	var len = first.children().length - 1;

	if (selects.length < len){
		var dd = link.parent().prev();
		first.parent().clone().insertAfter(dd).find('select').val(null);

		if (selects.length == len - 1)
			link.remove();
	}
}

$(function(){
	$('select')
});