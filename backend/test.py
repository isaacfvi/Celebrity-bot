from services import Services

aws = Services()
celebridade = 'abigail'

with open(f'../images/{celebridade}.jpeg', 'rb') as image_file:
    image_data = image_file.read()

celebrities = aws.get_celebrity(image_data)

print(aws.get_completion(celebrities))
