load("Deep_neural_net.mat");
 

          
input_layer=simu(5,0.00085,1000,0.0001);
input_layer_transposed=input_layer';

input_of_hidden_layer1=w1*input_layer_transposed;
output_of_hidden_layer1=sigmoid(input_of_hidden_layer1);
   
input_of_output_node=w2*output_of_hidden_layer1';
final_output=sum(input_of_output_node); %% will not matter