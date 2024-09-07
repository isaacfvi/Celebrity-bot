import boto3
import json

class Services:

    def __init__ (self, region: str = 'us-east-1', profile: str = 'tf-user'):
        self.session = boto3.Session(profile_name=profile, region_name=region)
        self.model_id = "anthropic.claude-v2"
        self.rekognition_client = self.session.client('rekognition')
        self.bedrock_client = self.session.client('bedrock-runtime')

    def get_celebrity(self, image: bytes):
        try:
            response = self.rekognition_client.recognize_celebrities(
            Image={
                'Bytes': image
            })

            celebrities = response.get("CelebrityFaces", [])
            names = [celebrity.get("Name") for celebrity in celebrities]

            return names
    
        except Exception as e:
            print(f"An error occurred while recognizing celebrities: {str(e)}")
            return []
    
    def get_completion(self, celebrities: list):
        try:
            celebrities = ", ".join(celebrities)

            prompt = f"Escreva um pequeno parágrafo contando uma curiosidade sobre a(s) celebridade(s) {celebrities} "
            
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
            print(f"An error occurred while getting completion from the model: {str(e)}")
            return "An error occurred."

        return response_text