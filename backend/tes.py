from services import Services

aws = Services()
celebridade = 'supernatural'

with open(f'../images/{celebridade}.jpeg', 'rb') as image_file:
    image_data = image_file.read()

celebrities = ['Jared Padalecki', 'Jensen Ackles'] #aws.get_celebrity(image_data)

print(celebrities)

aws.get_completion(celebrities)
