if (document.URL.match(/posts\/new|posts\/\d{1,4}\/edit/)){
  document.addEventListener('DOMContentLoaded', () => {

    const createImageHTML = (blob) => {
      const imageElement = document.getElementById('new-image');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('class', 'new-img')
      blobImage.setAttribute('src', blob);

      imageElement.appendChild(blobImage);
    };

    document.getElementById('post_image').addEventListener('change', (e) =>{
      const imageContent = document.querySelector('.new-img');
      if (imageContent){
        imageContent.remove();
      }

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);

    });
  });
}