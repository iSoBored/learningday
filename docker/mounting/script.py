import time

while True:
    with open("files/numbers.txt", "r") as f:
        contents = f.read()
        print(contents)

    time.sleep(5)