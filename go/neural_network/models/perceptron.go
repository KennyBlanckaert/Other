package models

import (
	"math"
	"math/rand"
	"time"

	"github.com/KennyBlanckaert/Other/tree/master/go/neural_network/utils"
)

// Perceptron Object
type Perceptron struct {
	Input        [][]float64
	ActualOutput []float64
	Weights      []float64
	Bias         float64
	Epochs       int
}

// Initialize - return: nil
func (p *Perceptron) Initialize() {
	rand.Seed(time.Now().UnixNano())

	p.Bias = 0.0
	p.Weights = make([]float64, len(p.Input[0]))
	for i := 0; i < len(p.Input[0]); i++ { // random weights
		p.Weights[i] = rand.Float64()
	}
}

// ForwardPropagation - return: float64
func (p *Perceptron) ForwardPropagation(x []float64) float64 {
	return p.sigmoid(utils.DotProduct(x, p.Weights) + p.Bias)
}

// Train - return: nil
func (p *Perceptron) Train() {
	for i := 0; i < p.Epochs; i++ {
		db := 0.0
		dw := make([]float64, len(p.Input[0]))

		for i, value := range p.Input {
			dw = utils.VectorAdd(dw, p.gradW(value, p.ActualOutput[i]))
			db += p.gradB(value, p.ActualOutput[i])
		}

		dw = utils.ScalarVectorMultiplication(2/float64(len(p.ActualOutput)), dw)
		p.Weights = utils.VectorAdd(p.Weights, dw)
		p.Bias += db * 2 / float64(len(p.ActualOutput))
	}
}

// sigmoid - return: float64
func (p *Perceptron) sigmoid(x float64) float64 {
	return 1.0 / (1.0 + math.Exp(-x))
}

// gradB - return: float64
func (p *Perceptron) gradB(x []float64, y float64) float64 {
	prediction := p.ForwardPropagation(x)
	return -(prediction - y) * prediction * (1 - prediction)
}

// gradW - return: []float64
func (p *Perceptron) gradW(x []float64, y float64) []float64 {
	return utils.ScalarVectorMultiplication(p.gradB(x, y), x)
}
