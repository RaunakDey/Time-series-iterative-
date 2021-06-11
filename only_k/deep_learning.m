function [w1,w2] = deep_learning(w1, w2, input_layer, correct_output)
alpha = 0.1; %learning rate

%run once
input_layer_transposed=input_layer';
input_of_hidden_layer1=w1*input_layer_transposed;
output_of_hidden_layer1=relu(input_of_hidden_layer1)';
   
   input_of_output_node=w2*output_of_hidden_layer1';
   final_output=sum(input_of_output_node); %% will not matter
   
   correct_output = correct_output';
   error =  correct_output' - final_output;
   
   delta=error;

   
error_of_hidden_layer1=w2'*delta;
delta1= (input_of_hidden_layer1>0).*error_of_hidden_layer1;

dw2=alpha*delta*output_of_hidden_layer1;
dw1=alpha*delta1*input_layer;
w1=w1+dw1;
w2=w2+dw2;

end

