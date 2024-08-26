var hamburger = document.querySelector(".hamburger");
var navMenu = document.querySelector(".nav-menu");
var navLinks = document.querySelectorAll(".nav-link");

hamburger.addEventListener("click", () => {
  hamburger.classList.toggle("active");
  navMenu.classList.toggle("active");
});

navLinks.forEach((link) => {
  link.addEventListener("click", () => {
    hamburger.classList.toggle("active");
    navMenu.classList.toggle("active");
  })
})

// This guide proved invaluable for me while I was trying to figure out
// how to make a responsive hamburger menu from scratch:
//
// https://dev.to/devggaurav/let-s-build-a-responsive-navbar-and-hamburger-menu-using-html-css-and-javascript-4gci
