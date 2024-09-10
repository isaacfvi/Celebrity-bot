import json

def lambda_handler(event, context):
    try:
        body = json.loads(event['body'])

        if(body["imagem"]):
            return {
            "statusCode": 200,
            "body": json.dumps({"status": "deu certo mano"})
        }
        
        return {
            "statusCode": 400,
            "body": json.dumps({"error": "Campo 'image' não encontrado na requisição."})
        }
    
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }
