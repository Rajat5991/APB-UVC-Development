# APB (Advanced Peripheral Bus) UVC Development

APB SIGNAL DESCRIPTION

PCLK – Generally System clock is directly connected to this
PRESETn – Active Low Asynchronous Reset
PADDR[31:0] – Address bus from Master to Slave, can be up 32 to bit wide
PWDATA[31:0] – Write data bus from Master to Slave, can be up to 32 bit wide
PRDATA[31:0] – Read data us from Slave to Master, can be up to 32 bit wide
PSELx – Slave select signal, there will be one PSEL signal for each slave connected to master. If master connected to ‘n’ number of slaves, PSELn is the maximum number of signals present in the system. (Eg: PSEL1,PSEL2,..,PSELn)
PENABLE – Indicates the second and subsequent cycles of transfer. When PENABLE is asserted, the ACCESS phase in the transfer starts.
PWRITE – Indicates Write when HIGH, Read when LOW
PREADY – It is used by the slave to include wait states in the transfer. i.e. whenever slave is not ready to complete the transaction, it will request the master for some time by de-asserting the PREADY.
PSLVERR – Indicates the Success or failure of the transfer. HIGH indicates failure and LOW indicates Success.


<img width="554" alt="image" src="https://github.com/user-attachments/assets/842f8e4e-262f-4ddc-aec2-92e0e87a3b43">
