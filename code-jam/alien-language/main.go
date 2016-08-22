package main

import (
	"bufio"
	"log"
	"os"
	"regexp"
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

		// convert string to regex pattern
		test = strings.Replace(test, "(", "[", -1)
		test = strings.Replace(test, ")", "]", -1)

		tests = append(tests, test)
	}
}

func main() {
	parseInput()

	// initialise results slice to the size numTests
	results = make([]int, numTests)

	for k, v := range tests {
		calculateNumOfMatches(k, v)
	}

	// print output (using result values written to results slice)
	log.Println(results)
}

func calculateNumOfMatches(key int, value string) {
	// build regex for current test case
	re := regexp.MustCompile(value)

	count := 0
	match := false

	for _, word := range words {
		match = re.MatchString(word)
		if match {
			count++
		}
	}

	results[key] = count
}
