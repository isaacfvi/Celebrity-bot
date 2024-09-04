import boto3
import json

class Services:

    def __init__ (self, region: str = 'us-east-1', profile: str = 'tf-user'):
        self.session = boto3.Session(profile_name=profile, region_name=region)

    def get_celebrity(self, image: bytes):

        client = self.session.client('rekognition')
        response = client.recognize_celebrities(
        Image={
            'Bytes': image
        })

        celebrities = response.get("CelebrityFaces", [])
        names = [celebrity.get("Name") for celebrity in celebrities]

        return names
    
    def get_completion(self, celebrities: list):
        client = self.session.client('bedrock-runtime')

        pass