import papaya.*;


float[][] a = {{1,2,1,2,5},{1,2,5,3,2}};

float[][] b = {{1,2},{3,4}};

float[][] d = a + b;

float[] c = Mat.column((d),1);

println(c);