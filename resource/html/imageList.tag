<!-- -*- mode:web -*- -->
<imageList>
    <div class="image-list">
	<div each={ images }>
	    <div class="thumbnail-base">
		<a href={ link }>
		    <img class="thumbnail" alt={ path } src={ path }/>
		</a>
	    </div>
	</div>
    </div>

    <script>
     this.images = [
     ];

     show(reload) {
	 if (reload) {
	     // Load image-list
	     $.getJSON( "api/images.json", function( data ) {
		 let img = []
		 $.each(data.images, function(k, v) {
		     img.push( {path: '/api/images/' + v,
				file: v,
				link: '#detail/' + v});
		 });

		 this.images = img;
		 this.update();
		 $('.image-list').show();
	     }.bind(this));
	 } else {
	     $('.image-list').show();
	 }
     }

     hide() {
	 $('.image-list').hide();
     }

    </script>

    <style>
     :scope {

     }
     .image-list {
	 display: flex;
	 flex-wrap: wrap;
     }
     .thumbnail {
	 max-width: 200px;
	 max-height: 200px;
     }
     .thumbnail-base {
	 display: flex;
	 justify-content: center;
	 align-items: center;

	 width: 200px;
	 height: 200px;
     }
    </style>
</imageList>
