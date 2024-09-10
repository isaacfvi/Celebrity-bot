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
            const apiResponse = await fetch('https://ftdkp0pevd.execute-api.us-east-1.amazonaws.com/fun-fact/', { // Substitua com sua URL de API
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ imagem: base64Image }),
            });

            if (!apiResponse.ok) {
                throw new Error('Erro na requisição para a API');
            }

            const data = await apiResponse.json();
            responseDiv.textContent = data.text; // Exibe o texto retornado pela API

        } catch (error) {
            responseDiv.textContent = `Erro: ${error.message}`;
        }
    };

    reader.readAsDataURL(file);
});
