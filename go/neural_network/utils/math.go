package utils

func DotProduct(v1 []float64, v2 []float64) float64 {
	result := 0.0
	for i := 0; i < len(v1); i++ {
		result += v1[i] * v2[i]
	}

	return result
}

func VectorAdd(v1 []float64, v2 []float64) []float64 {
	result := make([]float64, len(v1))
	for i := 0; i < len(v1); i++ {
		result[i] = v1[i] + v2[i]
	}

	return result
}

func ScalarVectorMultiplication(s float64, v []float64) []float64 {
	result := make([]float64, len(v))
	for i := 0; i < len(v); i++ {
		result[i] = s * v[i]
	}

	return result
}
