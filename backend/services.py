import boto3
import json

class Services:

    def __init__ (self):
        self.model_id = "anthropic.claude-v2"
        self.rekognition_client = boto3.client('rekognition')
        self.bedrock_client = boto3.client('bedrock-runtime')

    def get_celebrity(self, image: bytes):
        try:
            response = self.rekognition_client.recognize_celebrities(
            Image={
                'Bytes': image
            })

            celebrities = response.get("CelebrityFaces", ["Celebridades não encontradas"])
            names = [celebrity.get("Name") for celebrity in celebrities]

            return names
    
        except Exception as e:
            return ["Celebridades não encontradas"]
    
    def get_completion(self, celebrities: list):
        try:
            celebrities = ", ".join(celebrities)

            prompt = f"Compartilhe uma curiosidade interessante sobre {celebrities} de maneira natural e sem sair do assunto celebridade"
            
            body = {
                "anthropic_version": "bedrock-2023-05-31",
                "max_tokens": 250,
                "temperature": 0.9,
                "messages": [
                    {
                        "role": "user",
                        "content": [{"type": "text", "text": prompt}],
                    }
                ],
            }   

            body = json.dumps(body)

            response = self.bedrock_client.invoke_model(modelId=self.model_id, body=body)
            model_response = json.loads(response["body"].read())
            response_text = model_response["content"][0]["text"]

        except Exception as e:
            return f"Erro enquanto usava bedrock: {str(e)}"

        return response_text