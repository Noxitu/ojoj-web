//data-syntax-highlighting="c++11"

// c++ keywords: and|auto|bool|break|case|char|class|const|continue|default|delete|do|double|else|enum|false|float|for|if|inline|int|long|namespace|new|operator|private|public|register|return|short|signed|sizeof|static|struct|switch|template|this|true|typedef|typename|union|unsigned|using|void|while

$(document).on('ready page:load', function () {
  $('[data-do-syntax-highlighting="c++11"]').each( function() {
    $(this).attr('data-do-syntax-highlighting', null );
	$(this).attr('data-syntax-highlighting', '' );
	
	var src = $(this).html();
	var out = [];
	var regex = /((\n|^)\s*#[^\n]*)|(\/\/[^\n]*)|(\/\*[\s\S]*?\*\/)|(\b\d+([Ll]{0,2}[Uu]?|\.\d+[Ff]?)\b)|("[^"]*")|('[^']+')|(\b(and|auto|bool|break|case|char|class|const|continue|default|delete|do|double|else|enum|false|float|for|if|inline|int|long|namespace|new|operator|private|public|register|return|short|signed|sizeof|static|struct|switch|template|this|true|typedef|typename|union|unsigned|using|void|while)\b)/;
	
	function push_highlight( thing, cssclass ) {
		out.push( '<span class="syntax-highlighting-' );
		out.push( cssclass );
		out.push( '">' );
		out.push( thing );
		out.push( '</span>' );
	}
	
	while( true ) {
		var match = regex.exec(src);
		if( ! match )
			break;
		var pos = match.index;
		out.push(src.substr(0,pos));
		src = src.substr(pos);
		var thing = match[0];
		//console.log(match);
		
		if( match[1] )
			push_highlight( thing, 'preprocessor' );
		else if( match[3] || match[4] )
			push_highlight( thing, 'comment' );
		else if( match[5] || match[7] || match[8] )
			push_highlight( thing, 'constant' );
		else if( match[9] )
			push_highlight( thing, 'keyword' );
		else 
			push_highlight( thing, 'error' );
			
		src = src.substr(thing.length);
	}
	out.push( src );

	$(this).html(out.join(''));
  });
});