document.getElementById('fileInput').addEventListener('change', function() {
    const fileInput = document.getElementById('fileInput');
    const preview = document.getElementById('preview');
    const fileLabel = document.querySelector('.file-label');
    
    if (fileInput.files && fileInput.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
            preview.src = e.target.result;
            preview.style.display = 'block'; // Exibe a imagem
            fileLabel.style.marginTop = '10px'; // Move o ícone para baixo
        };
        reader.readAsDataURL(fileInput.files[0]);
    }
});

document.getElementById('uploadButton').addEventListener('click', async () => {
    const fileInput = document.getElementById('fileInput');
    const responseDiv = document.getElementById('response');

    if (fileInput.files.length === 0) {
        responseDiv.textContent = 'Por favor, selecione uma imagem primeiro.';
        return;
    }

    const file = fileInput.files[0];
    const reader = new FileReader();

    reader.onloadend = async () => {
        const base64Image = reader.result.split(',')[1];

        try {
            responseDiv.textContent = "Enviando imagem...";
            const apiResponse = await fetch(`${api_url}/`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ imagem: base64Image }),
            });

            if (!apiResponse.ok) {
                throw new Error('Parece que o bot está enfrentando problemas!');
            }

            const data = await apiResponse.json();
            responseDiv.textContent = data.fun_fact; // Exibe o texto retornado pela API

        } catch (error) {
            responseDiv.textContent = "Parece que o bot está enfrentando problemas!";
        }
    };

    reader.readAsDataURL(file);
});
