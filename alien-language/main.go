package main

import (
	"bufio"
	"log"
	"os"
)

const (
	inputFile = "A-small-practice.in"
)

var (
	// slice for storing the words of the alien language
	words []string
	// slice for storing all the test patterns
	tests []string
	// slice for storing the result of each test pattern
	results []int
	// slice used for caching results during each calculation of a test pattern
	temp []string
	// number of words in the language
	numWords int
	// number of test cases to run
	numTests int
)

func parseInput() {
	file, err := os.Open(inputFile)
	if err != nil {
		log.Println("error opening input file")
		return
	}

	reader := bufio.NewReader(file)

	// parse the 3 numbers on the first line
	// TODO: change to readBytes so I can convert to int and string more natively? (and learn more about byte slices!)
	l, _ := reader.ReadBytes('\n')
	log.Println(l)
	//l, _ := reader.ReadString('\n')
	//nums := strings.Split(l, " ")

	// TODO: either reimplement after the above to has been done (changed to byte slices) OR leave it as is
	//numWords = int(nums[1])
	/*numWords, _ = strconv.Atoi(nums[1])
	log.Println(numWords)

	l, _ = reader.ReadString('\n')
	log.Println(l)*/
}

func main() {
	parseInput()
}
