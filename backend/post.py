import requests
import base64

url = "https://ftdkp0pevd.execute-api.us-east-1.amazonaws.com/fun-fact/"  # Substitua pela URL do seu endpoint

# Abre a imagem e envia a requisição POST dentro do bloco `with open`
with open("../images/supernatural.jpeg", 'rb') as image_file:
    encoded_image = base64.b64encode(image_file.read()).decode('utf-8')

    data = {
    "imagem": encoded_image
    }

    response = requests.post(url, json=data)

# Verifica a resposta fora do bloco `with open`
if response.status_code == 200:
    print("Sucesso:", response.json())
else:
    print(f"Erro {response.status_code}: {response.text}")
