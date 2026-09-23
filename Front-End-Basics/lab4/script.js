// ----------------------------------------------Task 1----------------------------------------------
const targetElement = document.getElementById("target");
const nextElement = document.querySelector("#next");

const targetBackgroundColor = "red";
const targetFontColor = "white";

const nextBackgroundColor = "blue";
const nextFontColor = "yellow";

function setColorsByClick(elem, nextElem, targetBackground, targetFont, nextBackground, nextFont) {
    elem.addEventListener("click", () => {
        const currentColor = elem.style.backgroundColor;
        const nextElementCurrentColor = nextElem.style.backgroundColor;

        if (nextElementCurrentColor === "") {
            elem.style.backgroundColor = targetBackground;
            elem.style.color = targetFont;
        } else if (currentColor === targetBackground) {
            elem.style.backgroundColor = nextBackground;
            elem.style.color = nextFont;
            nextElem.style.backgroundColor = targetBackground;
            nextElem.style.color = targetFont;
        } else {
            elem.style.backgroundColor = targetBackground;
            elem.style.color = targetFont;
            nextElem.style.backgroundColor = nextBackground;
            nextElem.style.color = nextFont;
        }
    });
}

setColorsByClick(
    targetElement,
    nextElement,
    targetBackgroundColor,
    targetFontColor,
    nextBackgroundColor,
    nextFontColor
);

setColorsByClick(
    nextElement,
    targetElement,
    nextBackgroundColor,
    nextFontColor,
    targetBackgroundColor,
    targetFontColor
);

// ----------------------------------------------Task 2----------------------------------------------
const image = document.getElementById("image");

function imageAdd() {
    image.style.display = "Inline";
}
function imageZoomIn() {
    const currWidth = image.clientWidth;
    image.style.width = currWidth + 100 + "px";
}
function imageZoomOut() {
    const currWidth = image.clientWidth;
    image.style.width = currWidth - 100 + "px";
}
function imageDelete() {
    image.style.display = "None";
}
