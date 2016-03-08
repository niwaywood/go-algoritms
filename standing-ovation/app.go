package main

import "fmt"

func calcNumFriendsNeeded(audience string) int {
	// the total number of friends needed
	numFriends := 0
	// counter of the current number of people standing
	numStanding := 0

	// loop through audience and add friends when needed
	for i, c := range audience {
		n := int(c - '0')
		// don't need to perform any calculation if the number
		// of people with shyness level i is 0
		if n == 0 {
			continue
		}
		// if there is currently less people standing than is
		// required, add friends to cover the difference
		if numStanding < i {
			numFriends += i - numStanding
			numStanding = i
		}
		// enough people are now standing for the people with
		// shyness level i to stand
		numStanding += n
	}

	return numFriends
}

func main() {
	// global var for the test case loop
	var numFriends int
	// read in the number of test cases
	var T int
	// input is coming from Google, you can trust it :)
	_, _ = fmt.Scanln(&T)

	for t := 1; t <= T; t++ {
		var max int
		var audience string
		_, _ = fmt.Scanln(&max, &audience)

		numFriends = calcNumFriendsNeeded(audience)
		fmt.Printf("Case #%d: %d\n", t, numFriends)
	}
}
