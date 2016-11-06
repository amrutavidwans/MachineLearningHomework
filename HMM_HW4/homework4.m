% function homework4
% This is the main function for homework 4
% You are asked to plugin your implementation for algorithm, the argument is the q



clear all;close all;

load sp500;

prob1=algorithm(0.7);

hold on; 
prob2=algorithm(0.9);
plot(prob2(1,:),'r');
% end
