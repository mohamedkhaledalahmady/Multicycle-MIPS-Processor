# _**Muiltycycle MIPS Processor**_
> ## _Project Description_
   * Design of a 32-bit **_Multicycle Micro Architecture MIPS processor_** based on Von-Neumann architecture fully implemented RTL Verilog.

> ## _Contents_
   * _RTL files._
   * _Machine Code For 2 different programs._
        * [Factorial Program](Factorial.txt)
        * [GCD Program](GCD.txt)


> ## _Block Diagram_
![4](https://user-images.githubusercontent.com/67025780/222915750-254d5014-11f3-4366-93f0-0273003a659c.PNG)

> ## _Result Figures_
The processor was tested on Modelsim by three
* **Factorial program** (of the number `8`)
* **Fibonacci sequence**.
* **GCD of two numbers** (between `98` & `56`).

1. Factorial Program
![3](https://user-images.githubusercontent.com/67025780/222915822-6406c0e8-1c56-43d8-926e-2d874d24ec3c.PNG)


2. Fibonacci Program
![1](https://user-images.githubusercontent.com/67025780/222915818-4170992a-b2f8-4a87-a7be-cd404d411eaa.PNG)


3. GCD Program
![GCD(98,56)](https://user-images.githubusercontent.com/67025780/223853300-87dc2b32-ad77-42ee-9a7b-4c20033fb26c.PNG)

> ## __To store your program in instruction memory__
```verilog
    reg [width-1:0] memory [entries-1:0];
    initial begin
        $readmemh("your program.hex", memory);
    end
```


