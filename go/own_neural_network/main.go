package main

import (
	"github.com/KennyBlanckaert/Other/tree/master/go/own_neural_network/models"
)

// Main function
func main() {

	// 3 input values (x1, x2, x3)
	// Result (y1), always equal to x1
	var perceptron models.Perceptron
	perceptron.Input = [][]float64{{0, 0, 1}, {1, 1, 1}, {1, 0, 1}, {0, 1, 0}}
	perceptron.ActualOutput = []float64{0, 1, 1, 0}
	perceptron.Epochs = 1000

	perceptron.Initialize()
	perceptron.Train()

	// Should be close to 0
	print(perceptron.ForwardPropagation([]float64{0, 1, 0}), "\n")

	// Should be close to 1
	print(perceptron.ForwardPropagation([]float64{1, 0, 1}), "\n")
}
