function setCookie( cname, cvalue, exdays ) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires=" + d.toGMTString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
  }
  
  function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i < ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0) == ' ') {
        c = c.substring(1);
      }
      if (c.indexOf(name) == 0) {
        return c.substring(name.length, c.length);
      }
    }
    return "";
  }
  
  function checkCookie( cookieName ) {
    var c=getCookie( cookieName );
    if ( c != "") {
      return true;
    } else {
      return false;
    }
  }

$( function(){
    /* Set Current_url for main link                                */
	var loc = window.location.href, re = /#main/g, main_url='';
	main_url = loc.match( re ) ? loc : loc + '#main';
	$("#skip_url").attr('href', main_url );
  
    /* Prevent Click onn disabled features                       */
    $(".disabled").click( function(e){
        e.preventDefault();
    });

    /* Error Scroll                                             */
    // Add smooth scrolling to all links
    var hasErrors = $('.is-invalid').length;
    if ( hasErrors > 0 ){
        target=$('.is-invalid').first();
        $('html, body').animate({ scrollTop: target.offset().top - 120 }, 900 );
    }; 
    
    /* Form Password Check                                      */
    $(".toggle-password").click( function() {
        var input = $( $(this).prev('.form-control') ), icon= $(this).find('.paris-icon-eye');
        if (input.attr("type") == "password") {
            input.attr("type", "text");
            icon.css('fill','#E22C3f');
        } else {
            input.attr("type", "password");
            icon.css('fill','#071F32');
        }
    });
  
    $('input[type="password"]').keyup( function() {
        var v = $(this).val();
        if ( /[A-Z]/.test(v) ) {
            $(".uppercase").addClass("main-success-color");
        } else {
            $(".uppercase").removeClass("main-success-color");
        }
        if ( /\d/.test(v) ) {
            $(".digit").addClass("main-success-color");
        } else {
            $(".digit").removeClass("main-success-color");
        }
        if ( /^.*(?=.{8,99})/.test(v) ) {
            $(".charlength").addClass("main-success-color");
        } else {
            $(".charlength").removeClass("main-success-color");
        }
    });

    /* Responsive Table class xs-collapsed Toggle Datas                        */
    if( window.innerWidth < 580 ){
        $('.xs-collapsed td:first-child').click( function(){
            $(this).nextAll('td').toggleClass('d-block');
            $(this).toggleClass('open');
        });   
    }

    /* Accordion with border */
    $('.card.with-border .card-header').on('click', function(){
        if( $(this).children('.btn-accordion').hasClass('collapsed') ){
            $(this).closest('.card.with-border').addClass('open');
        } else {
            $(this).closest('.card.with-border').removeClass('open');
        }
    });
    
    /* List with More  */
    $('.btn-more').click( function(e){
        e.preventDefault();
        $(".list-more > .extra").toggleClass('hidden');
    });

    /* Infostep with More  */
    $('.btn-infostep-more').click( function(e){
        e.preventDefault();
        $(this).children('.link-label').toggle();
        $(this).children('.fa-angle-up').toggleClass('hidden');
        $(this).closest('.infostep-more').children('.extra').toggleClass('visually-hidden');
        $(this).closest('.infostep-more').children('.ellipsis').toggleClass('visually-hidden');
    });

    /* Navbar Scripts */
	// jQuery to collapse the navbar on scroll
    $(window).on('scroll load', function() {
		if ($(".navbar").offset().top > 60) {
			$(".fixed-top").addClass("top-nav-collapse");
		} else {
			$(".fixed-top").removeClass("top-nav-collapse");
		}
    });

	// jQuery for page scrolling feature - requires jQuery Easing plugin
	$(function() {
		$(document).on('click', 'a.page-scroll', function(event) {
			var $anchor = $(this);
			$('html, body').stop().animate({
				scrollTop: $($anchor.attr('href')).offset().top
			}, 600, 'easeInOutExpo');
			event.preventDefault();
		});
	});

    // closes the responsive menu on menu item click
    $(".navbar-nav li a").on("click", function(event) {
    if (!$(this).parent().hasClass('dropdown'))
        $(".navbar-collapse").collapse('hide');
    });

    /* Image Slider - Swiper */
    var imageSlider = new Swiper('.image-slider', {
        autoplay: {
            delay: 2000,
            disableOnInteraction: false
		},
        loop: true,
        spaceBetween: 30,
        slidesPerView: 4,
		breakpoints: {
            // when window is <= 580px
            580: {
                slidesPerView: 1,
                spaceBetween: 10
            },
            // when window is <= 768px
            768: {
                slidesPerView: 2,
                spaceBetween: 20
            },
            // when window is <= 992px
            992: {
                slidesPerView: 3,
                spaceBetween: 20
            },
            // when window is <= 1200px
            1200: {
                slidesPerView: 4,
                spaceBetween: 20
            },

        }
    });


    /* Text Slider - Swiper */
	var textSlider = new Swiper('.text-slider', {
        autoplay: {
            delay: 6000,
            disableOnInteraction: false
		},
        loop: true,
        navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev'
		}
    });

    
    /* Move Form Fields Label When User Types */
    // for input and textarea fields
    $("input, select, textarea").keyup(function(){
		if ($(this).val() != '') {
			$(this).addClass('input-filled');
		} else {
			$(this).removeClass('input-filled');
		}
    });

    /* Back To Top Button */
    // create the back to top button
    $('body').prepend('<a href="body" class="back-to-top page-scroll">Back to Top</a>');
    var amountScrolled = 700;
    $(window).scroll(function() {
        if ($(window).scrollTop() > amountScrolled) {
            $('a.back-to-top').fadeIn('500');
        } else {
            $('a.back-to-top').fadeOut('500');
        }
    });

	/* Removes Long Focus On Buttons */
	$(".button, a, button").mouseup(function() {
		$(this).blur();
	});

});