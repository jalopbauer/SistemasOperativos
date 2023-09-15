import os
import threading
import time
import sys
from random import randrange

import threading
import sys
import time
import random

readers = 0

def reader(readerNumber, mutex, write):
    while True:
        global readers
        mutex.acquire()
        readers += 1
        if readers == 1:
            write.acquire()
        mutex.release()
        read(readerNumber)
        mutex.acquire()

        if readers == 1:
            write.release()
        readers -= 1
        mutex.release()

def writer(writerNumber, write):
   while True:
    silentAction(writerNumber)
    write.acquire()
    write(writerNumber)
    write.release()

def read(actor):
    randomlyTimedSpacedAction(actor, "will read", "reading")

def write(actor):
    randomlyTimedSpacedAction(actor, "will write", "writing")

def silentAction(actor):
    secondsToSleep = randrange(1, 9)
    time.sleep(secondsToSleep)

def randomlyTimedSpacedAction(actor, actionName, actionFinishName):
    secondsToSleep = randrange(1, 9)
    print("Philosopher", actor, actionName, "for", secondsToSleep, "seconds")
    time.sleep(secondsToSleep)
    print("Philosopher", actor, "finished", actionFinishName)


def main(n, m):
    mutex = threading.Semaphore(1)
    write = threading.Semaphore(1)
    for readerNumber in range(n):
        threading.Thread(target=reader, args=(readerNumber, mutex, write)).start()
    for writerNumber in range(m):
        threading.Thread(target=writer, args=(writerNumber, write)).start()


if __name__ == '__main__':
    n = 4
    m = 2
    if len(sys.argv) > 1:
        n = int(sys.argv[1])
    if len(sys.argv) > 2:
        m = int(sys.argv[2])
    main(n, m)

