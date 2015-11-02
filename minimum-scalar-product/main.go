// optimal solution

package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

const inputFile = "A-tiny-practice.in"

func main() {
	file, err := os.Open(inputFile)
	if err != nil {
		panic(err)
	}
	defer file.Close()

	r := bufio.NewScanner(file)

	// read number of test cases
	r.Scan()
	line := r.Text()
	numTestCases, _ := strconv.Atoi(line)

	// make tmp vars for the for loop
	vector1 := make([]int, 0, 0)
	vector2 := make([]int, 0, 0)
	numDimensions := 0
	result := 0

	// for each test case (first num in file)
	for i := 1; i <= numTestCases; i++ {
		// read test case data (3 lines of input)
		r.Scan()
		numDimensions, _ = strconv.Atoi(r.Text())

		r.Scan()
		sV1 := strings.SplitN(r.Text(), " ", numDimensions)
		for _, sNum := range sV1 {
			num, _ := strconv.Atoi(sNum)
			vector1 = append(vector1, num)
		}

		r.Scan()
		sV2 := strings.SplitN(r.Text(), " ", numDimensions)
		for _, sNum := range sV2 {
			num, _ := strconv.Atoi(sNum)
			vector2 = append(vector2, num)
		}

		// sort slices
		sort.Ints(vector1)
		sort.Ints(vector2)

		// reverse one of the slices and compute the MSP
		for j := 0; j < numDimensions; j++ {
			result += vector1[j] * vector2[numDimensions-j-1]
		}
		// output the test case result to stdout
		fmt.Println("Test Case", i, ":", result)

		// clear tmp vars
		result = 0
		vector1 = nil
		vector2 = nil
	}
}
