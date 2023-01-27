#!/usr/bin/env python3

import random
import sys


def main():
    seed = int(sys.argv[1]) + 123
    random.seed(seed)


if __name__ == "__main__":
    main()

