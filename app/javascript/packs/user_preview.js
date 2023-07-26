if (document.URL.match(/users\/\d{1,4}\/edit/)){
  document.addEventListener('DOMContentLoaded', () => {

    const createImageHTML = (blob) => {
      const imageElement = document.getElementById('profile-image');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('class', 'user-new-img')
      blobImage.setAttribute('src', blob);

      imageElement.appendChild(blobImage);
    };

    document.getElementById('user_profile_image').addEventListener('change', (e) =>{
      const imageContent = document.querySelector('.user-new-img');
      if (imageContent){
        imageContent.remove();
      }

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);

    });
  });
}