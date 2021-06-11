
N=1000;
w1= 2*rand(N-1,N)-1; % 20 nodes in hidden1, 25 inputs
w2= 2*rand(1,N-1)-1 ;   



for epoch=1:1000    
for fc_used=1:10
 input_layer=simu(fc_used,0.00085,N,0.0001);  
 correct_output=fc_used;
    [w1, w2] = deep_learning(w1, w2, input_layer, correct_output);
end
epoch
end



save("Deep_neural_net.mat");

            








