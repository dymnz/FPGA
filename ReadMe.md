### FPGA


* [Quartus II Testbench Tutorial](https://class.ee.washington.edu/271/peckol/doc/DE1-SoC-Board-Tutorials/ModelsimTutorials/QuartusII-Testbench-Tutorial.pdf)



#### Stuff

* ModelSim won't open
    * Tools -> Options -> EDA Tool Options -> ModelSim-Altera: Add `\` at the end of the link


* Compile time
    * Assignments -> Settings -> Compilation Process Settings -> Maximum processors allowed: `1`
    * Assignments -> Settings -> Compilation Process Settings -> Physical Synthesis Optimizations -> Effort level: `Fast`
    * 
    *Parallel compilation is slower then signle-thread for some reason*


* I don't want to stare at the screen when compiling
    * https://github.com/dymnz/TellMeWhenItsDone