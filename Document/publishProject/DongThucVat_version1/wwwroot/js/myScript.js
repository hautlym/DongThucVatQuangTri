$(document).ready(function(){
	var b = true;
	
    $(window).scroll( function(){
        $('#content .gioithieu ul li img, #content .gioithieu ul li b, #content .gioithieu h2, #content .gioithieu p, #content .loiich h2, #content .dichvu h2, #content .doitac h2, #content .doitac ul li').each( function(){
            var bottom_of_object = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            if( bottom_of_window > bottom_of_object ){
                $(this).delay(500).animate({'opacity':'1', 'top':'0'},800);
            }
        });
		
		$('#content .loiich ul li, #content .dichvu ul li').each( function(){
            var bottom_of_object = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            if( bottom_of_window > bottom_of_object ){
                $(this).delay(500).animate({'opacity':'1', 'left':'0'},400);
            }
        });
    });
	
	
	
	$("#content .slide").slick({
		dots: true,
		infinite: true,
		speed: 300,
		slidesToShow: 1,
		slidesToScroll: 1,
		autoplay: true,
		centerMode: false,
		variableWidth: false,
		centerPadding:0,
		rows:1,
		arrows:false,
		focusOnSelect: true,
		});
	
	$("#header .header2 .nav .navBtn, #header .header2 .nav ul li a").click(function() {
		$(this).next().stop().slideToggle(200);
	});
	
	$( '#cd-dropdown' ).dropdown( {
		gutter : 5,
		stack : false,
		delay : 100,
		slidingIn : 100
	} );
 });