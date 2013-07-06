// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

// $(document).ready(function(){


  $('table td a').click(function(){
      $('table td a').removeClass('active-link');
      $(this).addClass('active-link');
      alert($this);
  });

// function changeNavClass() {
//   var pathname = window.location.pathname;

//     alert(pathname);
//     if(pathname.checkString("appointment"))
//     // $('.side-nav li').removeClass('active');
//     // //alert("AAAA");
//     // $(this).parent().addClass('active');
// }

// function checkString(word){

//   if (this.contains(word)){
//     return true;
//   }
//   else
//   {
//     return false;
//   }

// }




