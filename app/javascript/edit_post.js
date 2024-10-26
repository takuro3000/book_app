
const ratingStars = document.querySelector(".edit-ratings").children; // 'stars'を'ratingStars'に変更
const ratingEditValue = document.getElementById("edit-rating-value");
const ratingEditValueDisplay = document.getElementById("edit-rating-value-display");
let indexedit;

for(let i=0; i<ratingStars.length; i++){
    console.log(ratingStars.length);
    ratingStars[i].addEventListener("mouseover", function(){
    for(let j=0; j<ratingStars.length; j++){
        ratingStars[j].classList.remove("fa-solid");
        ratingStars[j].classList.add("fa-regular");
    }
    for(let j=0; j<=i; j++){
        ratingStars[j].classList.remove("fa-regular");
        ratingStars[j].classList.add("fa-solid");
    }
    });

    ratingStars[i].addEventListener("click", function(){
    ratingEditValue.value = i+1;
    ratingEditValueDisplay.textContent = ratingEditValue.value;
    indexedit = i;
    });

    ratingStars[i].addEventListener("mouseout", function(){
    for(let j=0; j<ratingStars.length; j++){
        ratingStars[j].classList.remove("fa-solid");
        ratingStars[j].classList.add("fa-regular");
    }
    for(let j=0; j<=indexedit; j++){
        ratingStars[j].classList.remove("fa-regular");
        ratingStars[j].classList.add("fa-solid");
    }
    });
}
  