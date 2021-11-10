package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
	"github.com/anaskhan96/soup"
)

func main() {
	/* Create a reader of Stdin */
	reader := bufio.NewReader(os.Stdin)

	/* Start the main loop */
		/* Asks User to the city */
	fmt.Printf("Enter the name of the city : ")

	/* Stores the string, clean the jump and concatenate in another String */
	city, _ := reader.ReadString('\n')
	city = strings.Replace(city,"\n", "", -1)
	// cityInURL := strings.Join(strings.Split(city, " "), "+")

	/*  */
	url := "https://www.bing.com/search?q=weather+" + city
	resp, err := soup.Get(url)
	if err != nil {
		log.Fatal(err)
	}
	doc := soup.HTMLParse(resp)
	grid := doc.FindStrict("div", "class", "b_antiTopBleed b_antiSideBleed b_antiBottomBleed noPointerEvents")
	heading := grid.Find("div", "class", "wtr_hero").Find("div").Text()
	conditions := grid.Find("div", "class", "wtr_condition")
	primaryCondition := conditions.Find("div")
	secondaryCondition := primaryCondition.FindNextElementSibling()
	temp := primaryCondition.Find("div", "class", "wtr_condiTemp").Find("div").Text()
	others := primaryCondition.Find("div", "class", "wtr_condiAttribs").FindAll("div")
	caption := secondaryCondition.Find("div").Text()
	fmt.Println("City Name : " + heading)
	fmt.Println("Temperature : " + temp + "˚C")
	for _, i := range others {
		fmt.Println(i.Text())
	}
	fmt.Println(caption)
}
