import sys, getopt
from controller import *
def main(argv):
    inputfile = ''
    outputfile = ''
    data = ''
    try:
        opts, args = getopt.getopt(argv,"hi:o:",["ifile=","ofile="])
    except getopt.GetoptError:
        print ('main.py -i <inputfile> -o <outputfile>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print ('test.py -i <inputfile> -o <outputfile>')
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfile = arg
        elif opt in ("-o", "--ofile"):
            outputfile = arg

    with open("tests/" + inputfile, "r") as input_file:
        text = input_file.read()
        data = start(text)
        pass

    with open("out/" + outputfile, "w") as output_file:
        # write result to output file.
        # for the sake of testing :
        output_file.write(data)


if __name__ == "__main__":
    main(sys.argv[1:])