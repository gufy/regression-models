global ping;
ping = @() (system('kinit -R') && display('baf'));

I = 0;

I = I + 1;
models{I} = struct('name', 'Forests', 'model', @forestsSim);
NTrees = [1000]; %[50; 100; 200; 400; 800];
MinLeaf = [1]; %[1; 2; 5; 10; 20; 50];
models{I}.params = explodeStruct(struct(), allcombs( NTrees , MinLeaf ), {'NTrees', 'MinLeaf'});
