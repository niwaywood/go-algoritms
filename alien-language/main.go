package main

import (
	"bufio"
	"log"
	"os"
	"strconv"
	"strings"
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

	reader := bufio.NewScanner(file)

	// parse the 3 numbers on the first line
	reader.Scan()
	l := reader.Text()

	nums := strings.Split(l, " ")

	numWords, _ = strconv.Atoi(nums[1])
	numTests, _ = strconv.Atoi(nums[2])

	log.Println("words:", numWords, "tests:", numTests)

	// read the words into words slice
	for i := 0; i < numWords; i++ {
		// read next line
		reader.Scan()
		word := reader.Text()

		words = append(words, word)
	}

	// read the tests into tests slice
	for i := 0; i < numTests; i++ {
		// read next line
		reader.Scan()
		test := reader.Text()

		tests = append(tests, test)
	}

	log.Println(len(tests), tests)
}

func main() {
	parseInput()
}
