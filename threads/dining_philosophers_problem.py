import os
import threading
import time
import sys
from random import randrange


def philosopher(philosopherNumber, chopsticks, thinkFunction=lambda a : think(a), eatFunction=lambda a : eat(a)) :
    while True:
        thinkFunction(philosopherNumber)
        takeChopsticks(philosopherNumber, chopsticks)
        eatFunction(philosopherNumber)                 
        releaseChopsticks(philosopherNumber, chopsticks)

def think(philosopherNumber):
    randomlyTimedSpacedphilosopheraction(philosopherNumber, "will think", "thinking")

def eat(philosopherNumber):
    randomlyTimedSpacedphilosopheraction(philosopherNumber, "will eat", "eating")

def randomlyTimedSpacedphilosopheraction(philosopherNumber, actionName, actionFinishName):
    secondsToSleep = randrange(1, 9)
    print("Philosopher", philosopherNumber, actionName, "for", secondsToSleep, "seconds")
    time.sleep(secondsToSleep)
    print("Philosopher", philosopherNumber, "finished", actionFinishName)

def takeChopsticks(philosopherNumber, chopsticks):
    chopsticks[philosopherNumber].acquire()
    chopsticks[(philosopherNumber + 1) % len(chopsticks)].acquire()

def releaseChopsticks(philosopherNumber, chopsticks):
    chopsticks[philosopherNumber].release()
    chopsticks[(philosopherNumber + 1) % len(chopsticks)].release()


def main(n):
    chopsticks = [threading.Semaphore(1) for _ in range(n + 1)]
    for i in range(n):
        threading.Thread(target=philosopher, args=(i, chopsticks)).start()

if __name__ == '__main__':
    n = 5
    if len(sys.argv) > 1:
        n = int(sys.argv[1])
    main(n)
