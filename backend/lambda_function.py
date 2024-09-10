import json
import base64
from services import Services

def process_event(imagem):
    aws = Services()
    celebrities = aws.get_celebrity(imagem)
    return aws.get_completion(celebrities)

def lambda_handler(event, context):
    try:
        body = json.loads(event.get('body'))

        if "imagem" in body:

            imagem = base64.b64decode(body["imagem"])
            result = process_event(imagem)

            return {
            "statusCode": 200,
            "body": json.dumps({"fun_fact": result})
            }
        
        else:
            return {
            "statusCode": 400,
            "body": json.dumps({"status": "Bad request: sem imagem na requisição"})
            }
        
    except json.JSONDecodeError:
        return {
            "statusCode": 400,
            "body": json.dumps({"error": "Bad request: JSON inválido"})
        }
    
    except Exception as e:
            return {
            "statusCode": 500,
            "body": json.dumps({"error": "Erro enquanto processava a imagem: " + str(e)})
            }
