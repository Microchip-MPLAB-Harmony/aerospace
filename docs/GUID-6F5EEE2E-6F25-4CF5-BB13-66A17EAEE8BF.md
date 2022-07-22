# IP1553_BcStartDataTransfer

```c
void IP1553_BcStartDataTransfer(IP1553_DATA_TX_TYPE transferType, uint8_t txAddr, uint8_t txSubAddr, uint8_t rxAddr, uint8_t rxSubAddr, uint8_t dataWordCount, IP1553_BUS bus )
```

**Summary**

Start BC command for data transfer

**Preconditions**

IP1553_Initialize must have been called for the IP1553 instance IP1553_BuffersConfigSet must have been called to set allocated buffers IP1553_ResetRxBuffersStatus and IP1553_ResetTxBuffersStatus must have been called for the concerned buffers (sub-address) used in the command.

**Parameters**

* *transferType* - Type of data transfer command to issue
* *txAddr* - The transmitter address : 0 if BC, RT address otherwise
* *txSubAddr* - The transmitter sub-address
* *rxAddr* - The receiver address : 0 if BC, RT address otherwise
* *rxSubAddr* - The receiver sub-address
* *dataWordCount* - Number of data word (16 bit) to read/write. 0 stand for 32 data word
* *bus* - Indicate if the transfer uses physical BUS A or B

**Returns**

None

