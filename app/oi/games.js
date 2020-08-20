// inspired by:
// https://codepen.io/yelly/pen/jZQVBJ
//  A parking project to show how to use the HTML Drag and Drop API.

/*
GAME_TYPE == 2      images above and below
GAME_TYPE == 3      images above only (the default)
GAME_TYPE == 4      images are not square

ROWS = 1            one row for draggables  and one for dropzones
ROWS = 1.5          one row for draggables  and two for dropzones; these are the puzzles.
ROWS = 2            two rows for draggables and two for dropzones
*/


let dragged; //store the object being dragged
var score = 0;
var tries = 0;

function onDragStart(event) {
  let target = event.target;
  if (target && target.nodeName === 'IMG' && target.draggable) { // If target is an image and not already placed (for firefox)
    dragged = target;
    event.dataTransfer.setData('text', target.id);
    // Make it half transparent
    event.target.style.opacity = .6;
  }
}

function onDragEnd(event) {
  if (event.target && event.target.nodeName === 'IMG') {
      // if the target is still draggable, Reset the transparency
      if (event.target.draggable) {
        event.target.style.opacity = '';
      }
      else {
        event.target.style.opacity = 0.1;
      };
    dragged = null;
  }
}

function onDragOver(event) {
  // Prevent default to allow drop
  event.preventDefault();
  event.dataTransfer.dropEffect = "move"
}

function onDragLeave(event) {
  event.target.style.background = '';
}

function onDragEnter(event) {
  // const target = event.target;
  // if (dragged && target) {
  //    }
  //   else {
  //   }
  // }
}

function onDrop(event) {
  event.preventDefault();
  const target = event.target;
  if (target) {
    if (target.id && target.id.startsWith("drop")) {
      const data = event.dataTransfer.getData('text');
      const dragged = document.getElementById(data);
      if (dragged){ // for firefox
        target.style.backgroundColor = '';
        if (dragged.id.slice(dragged.id.length -2) === target.id.slice(target.id.length -2)) {
           event.preventDefault();
           // Get the id of the target and add the moved element to the target's DOM
           dragged.style.opacity = '';
           dragged.setAttribute("draggable","false"); // doesnt work in firefox
           target.replaceWith(dragged.cloneNode());
           score++;
        } else {
          tries++;
        }
      }
    }
  }
}

function randomize_images() {
  var images=[];
  while (images.length < NUMBER_OF_IMAGES) {
    next_number = Math.floor(Math.random() * NUMBER_OF_IMAGES) + 1;
    if (! images.includes(next_number)) {
      images.push(next_number);
    }
  }
  return images;
}

// add drop dropZones and draggables

var draggables = document.getElementById("draggables");
var row = document.createElement("div");
row.id = "draggables_row_01";
row.classList.add("row");
draggables.appendChild(row);
if (ROWS == 2){
  var row = document.createElement("div");
  row.id = "draggables_row_02";
  row.classList.add("row");
  draggables.appendChild(row);
}
draggables = document.getElementById("draggables_row_01");

var draggableImage = document.createElement("img");
draggableImage.src = "../../images/card.svg"

var dropzones = document.getElementById("dropzones");
var row = document.createElement("div");
row.id = "dropzones_row_01";
row.classList.add("row");
dropzones.appendChild(row);
if (ROWS == 1.5 || ROWS == 2){
  var row = document.createElement("div");
  row.classList.add("row");
  row.id = "dropzones_row_02";
  dropzones.appendChild(row.cloneNode());
}
dropzones = document.getElementById("dropzones_row_01");


var dropzoneImage = document.createElement("img");
dropzoneImage.src = "../../images/card-light.png"
dropzoneImage.width=200
dropzoneImage.height=200

if ( GAME_TYPE == 4) {
  dropzoneImage.src = "../../images/card-not-square.png"
}
for (var i = 1 ; i <= NUMBER_OF_IMAGES; i++) {

  if (ROWS == 2 && i > (NUMBER_OF_IMAGES/2) ){
    draggables = document.getElementById("draggables_row_02");
    dropzones = document.getElementById("dropzones_row_02");
  }

  if (ROWS == 1.5 && i > (NUMBER_OF_IMAGES/2) ){
    dropzones = document.getElementById("dropzones_row_02");
  }


  draggableImage.id =  'placeholder' + i.toString().padStart(2, "0");
  var newDraggableImage = draggableImage.cloneNode();

  draggables.appendChild(newDraggableImage);

  dropzoneImage.id =  'drop_placeholder' + i.toString().padStart(2, "0");
  var newDropzoneImage = dropzoneImage.cloneNode();
  newDropzoneImage.addEventListener('drop', onDrop);
  newDropzoneImage.addEventListener('dragenter', onDragEnter);
  newDropzoneImage.addEventListener('dragleave', onDragLeave);
  newDropzoneImage.addEventListener('dragover', onDragOver);

  dropzones.appendChild(newDropzoneImage);

}

// place the images in the draggables
randomize_images().forEach(function(image_number, index) {
  var myImage = new Image(200, 200);
  var new_img = './images/' + image_number.toString().padStart(2, "0") + '.png';
  var img_id = 'img' + image_number.toString().padStart(2, "0");
  var old_img_id = 'placeholder' + (index + 1).toString().padStart(2, "0");
  myImage.src = new_img;
  myImage.id = img_id;
  myImage.addEventListener('dragstart', onDragStart);
  myImage.addEventListener('dragend', onDragEnd);
  myImage.onclick = function(){zounds.playURL('../../woorden/pap/' + image_number.toString().padStart(2, '0') + '.mp3')};

  var oldImage = document.getElementById(old_img_id);
  oldImage.replaceWith(myImage);

});

// place the images in the dropzone if GAME_TYPE needs that
  if (GAME_TYPE == 2){
    randomize_images().forEach(function(image_number, index) {
      var myImage = new Image(200, 200);
      var new_img_src = './images/' + image_number.toString().padStart(2, "0") + '-match.png';
      var new_img_id = 'drop' + image_number.toString().padStart(2, "0");
      var old_img_id = 'drop_placeholder' + (index + 1).toString().padStart(2, "0");
      console.log(new_img_id);
      myImage.src = new_img_src;
      myImage.id = new_img_id;
      myImage.addEventListener('drop', onDrop);
      myImage.addEventListener('dragenter', onDragEnter);
      myImage.addEventListener('dragleave', onDragLeave);
      myImage.addEventListener('dragover', onDragOver);

      var oldImage = document.getElementById(old_img_id);
      oldImage.replaceWith(myImage);
    });
  }

  if (ROWS > 1){
    document.getElementById("dropzones").classList.add("poepie");
  }

  if (ROWS == 1.5){
    document.getElementById("dropzones").classList.add("puzzle");
  }
