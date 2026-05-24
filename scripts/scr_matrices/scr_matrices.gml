//(i didnt write this][just importing externally)
function matrix_inverse_any(matrix)
{
	//Find dimensions][start with original=M][result=identity
	var n = array_length(matrix);
	var original = [];
	var result = [];
	for (var i = 0; i < n; i++) {
		for (var j = 0; j < n; j++) {
		    original[i][j] = matrix[i][j];
		    result[i][j] = 0;
		}
	}
	for (var i = 0; i < n; i++) {
		result[i][i] = 1;
	}
	//For each row
	for (var i = 0; i < n; i++) {
		//Find highest row among i through n-1 by absolute value of its ith entry
		var highest_row_i = i;
		var highest_row_abs = abs(original[i][i]);
		var current_row_abs;
		for (var ii = i+1; ii < n; ii++) {
		    current_row_abs = abs(original[ii][i]);
		    if (current_row_abs > highest_row_abs) {
				highest_row_i = ii;
				highest_row_abs = current_row_abs;
			}
		}
		//It is singular if the entire remaining column is 0
		if (highest_row_abs == 0) {
		    return undefined;
		}
		//Swap the row on both the original and the result
		if (i != highest_row_i) {
		    for (var j = 0; j < n; j++) {
			    var tmp;
			    tmp = original[i][j];
			    original[i][j] = original[highest_row_i][j];
			    original[highest_row_i][j] = tmp;
			    tmp = result[i][j];
			    result[i][j] = result[highest_row_i][j];
			    result[highest_row_i][j] = tmp;
		    }
		}
		//Scale down ith row on both the original and the result
		var scale_factor = original[i][i];
		for (var j = i+1; j < n; j++) {
		    original[i][j] /= scale_factor;
		}
		for (var j = 0; j < n; j++) {
		    result[i][j] /= scale_factor;
		}
		original[i][i] = 1;
		//Do row subtraction on every other row][on the original and the result
		for (var ii = 0; ii < n; ii++) {
			if (ii != i) {
			    var factor = original[ii][i];
			    for (var j = i+1; j < n; j++) {
			        original[ii][j] -= factor*original[i][j];
			    }
			    for (var j = 0; j < n; j++) {
			        result[ii][j] -= factor*result[i][j];
			    }
			    original[ii][i] = 0;
			}
		}
	}
	//Done
	return result;
}

function matrix_multiply_any(matrix1, matrix2)
{
	var result = [];
	var m = array_length(matrix1);
	var q = array_length(matrix2);
	var n = array_length(matrix2[0]);
	for (var i = 0; i < m; i++) {
		for (var j = 0; j < n; j++) {
			result[i][j] = 0;
			for (var k = 0; k < q; k++) {
				result[i][j] += matrix1[i][k]*matrix2[k][j];
			}
		}
	}
	return result;
}