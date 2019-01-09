<!-- -*- mode:web -*- -->
<app-main>

    <imageList></imageList>
    <imageDetail></imageDetail>
    

    <script>
     var self = this;
     /*      console.log(this.tags["image-list"]) */

     
     var r = route.create()
     r('', home)
     r('detail/*', detail)

     

     /*      this.image-view.url = "/api/images/001.jpg"; */



     function home() {
	 self.tags.imagedetail.hide();
	 self.tags.imagelist.show(true);
     }

     function detail(file) {
	 console.log(self.tags.imagedetail);
	 self.tags.imagelist.hide();
	 self.tags.imagedetail.show(file);
	 /* self.tags.imagedetail.update(); */
     }
    </script>

    <style>
     app-main {
	 height: 100%;

     }
    </style>    
</app-main>
