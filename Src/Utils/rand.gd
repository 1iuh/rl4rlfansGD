class_name Rand
extends Object


static func weighted_pick(array: Array, weights: Array): 
    var total_weight = weights.reduce(func(sum, n := 0): return sum + n) 
    var random := randi_range(0, total_weight) 
    var accumulated_weight := 0 
    for i in weights.size(): 
        accumulated_weight += weights[i] 
        if random < accumulated_weight: return array[i] 
    return array[-1]
