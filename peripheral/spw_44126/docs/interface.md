# SPW Library Interface

#### Data Types and Constants
* [SPW IRQ status](##-spw-irq-status)
* [SPW Callback](##-spw-callback)
* [SPW PLib Instance Object](##-spw-plib-instance-object)
* [SPW link](##-spw-link)
* [SPW LINK status](##-spw-link-status)
* [SPW LINK state](##-spw-link-state)
* [SPW LINK IRQ status](##-spw-link-irq-status)
* [SPW PKTRX status](##-spw-pktrx-status)
* [SPW PKTRX previous buffer status](##-spw-pktrx-previous-buffer-status)
* [SPW PKTRX interrupt status](##-spw-pktrx-interrupt-status)
* [SPW PKTRX next receive buffer start condition](##-spw-pktrx-next-receive-buffer-start-condition)
* [SPW PKTRX packet information data](##-spw-pktrx-packet-information-data)
* [SPW PKTTX status](##-spw-pkttx-status)
* [SPW PKTTX Previous status](##-spw-pkttx-previous-status)
* [SPW PKTTX interrupt status](##-spw-pkttx-interrupt-status)
* [SPW PKTTX next send list start mode](##-spw-pkttx-next-send-list-start-mode)
* [SPW PKTTX send list entry](##-spw-pkttx-send-list-entry)
* [SPW RMAP status](##-spw-rmap-status)
* [SPW RMAP Error Code](##-spw-rmap-error-code)
* [SPW ROUTER table physical address](##-spw-router-table-physical-address)
* [SPW ROUTER status](##-spw-router-status)
* [SPW ROUTER Timeout status](##-spw-router-timeout-status)

#### Initialization functions
* [SPW_Initialize](##-spw_initialize)
* [SPW_LINK_Initialize](##-spw_link_initialize)
* [SPW_RMAP_Initialize](##-spw_rmap_initialize)
* [SPW_ROUTER_Initialize](##-spw_router_initialize)

#### Setup functions
* [SPW_CallbackRegister](##-spw_callbackregister)
* [SPW_LINK_InterruptEnable](##-spw_link_interruptenable)
* [SPW_LINK_InterruptDisable](##-spw_link_interruptdisable)
* [SPW_PKTRX_SetDiscard](##-spw_pktrx_setdiscard)
* [SPW_PKTRX_SetNextBuffer](##-spw_pktrx_setnextbuffer)
* [SPW_PKTRX_InterruptEnable](##-spw_pktrx_interruptenable)
* [SPW_PKTRX_InterruptDisable](##-spw_pktrx_interruptdisable)
* [SPW_PKTRX_CurrentPacketAbort](##-spw_pktrx_currentpacketabort)
* [SPW_PKTRX_CurrentPacketSplit](##-spw_pktrx_currentpacketsplit)
* [SPW_PKTTX_InterruptEnable](##-spw_pkttx_interruptenable)
* [SPW_PKTTX_InterruptDisable](##-spw_pkttx_interruptdisable)
* [SPW_PKTTX_SetNextSendList](##-spw_pkttx_setnextsendlist)
* [SPW_PKTTX_UnlockStatus](##-spw_pkttx_unlockstatus)
* [SPW_ROUTER_TimeoutDisable](##-spw_router_timeoutdisable)
* [SPW_ROUTER_LogicalAddressRoutingEnable](##-spw_router_logicaladdressroutingenable)
* [SPW_ROUTER_FallbackEnable](##-spw_router_fallbackenable)
* [SPW_ROUTER_RoutingTableEntrySet](##-spw_router_routingtableentryset)

#### Status functions
* [SPW_LINK_StatusGet](##-spw_link_statusget)
* [SPW_LINK_IrqStatusGetMaskedAndClear](##-spw_link_irqstatusgetmaskedandclear)
* [SPW_PKTRX_StatusGet](##-spw_pktrx_statusget)
* [SPW_PKTRX_IrqStatusGetMaskedAndClear](##-spw_pktrx_irqstatusgetmaskedandclear)
* [SPW_PKTRX_GetPreviousBufferStatus](##-spw_pktrx_getpreviousbufferstatus)
* [SPW_PKTTX_StatusGet](##-spw_pkttx_statusget)
* [SPW_PKTTX_IrqStatusGetMaskedAndClear](##-spw_pkttx_irqstatusgetmaskedandclear)
* [SPW_RMAP_StatusGetAndClear](##-spw_rmap_statusgetandclear)
* [SPW_ROUTER_StatusGet](##-spw_router_statusget)
* [SPW_ROUTER_TimeoutStatusGet](##-spw_router_timeoutstatusget)


---

## SPW IRQ status
```C
typedef enum
{
    SPW_INT_MASK_NONE = 0,
    SPW_INT_MASK_PKTRX1 = ( 1 << 0),
    SPW_INT_MASK_PKTTX1 = ( 1 << 1),
    SPW_INT_MASK_TCH = ( 1 << 2),
    SPW_INT_MASK_LINK2 = ( 1 << 3),
    SPW_INT_MASK_DIA2 = ( 1 << 4),
    SPW_INT_MASK_DI2 = ( 1 << 5),
    SPW_INT_MASK_LINK1 = ( 1 << 6),
    SPW_INT_MASK_DIA1 = ( 1 << 7),
    SPW_INT_MASK_DI1 = ( 1 << 8),
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_INT_MASK_INVALID = 0xFFFFFFFF
} SPW_INT_MASK;
```

**Summary**:   
&nbsp;&nbsp;Identifies the SPW IRQ lines that have pending interrupt   

**Description**:
&nbsp;&nbsp;This data type identifies the SPW IRQ lines that have pending interrupt   

---

## SPW Callback
```C
typedef void (*SPW_CALLBACK) (SPW_INT_MASK irqStatus, uintptr_t contextHandle)
```

**Summary**:   
&nbsp;&nbsp;SPW Callback Function Pointer.

**Description**:   
&nbsp;&nbsp;This data type defines the required function signature for the SPW callback function.   
&nbsp;&nbsp;Application must register a pointer to a callback function whose function signature   
&nbsp;&nbsp;(parameter and return value types) match the types specified by this function pointer   
&nbsp;&nbsp;in order to receive callback from the PLIB.    
&nbsp;&nbsp;The parameters and return values are described here and a partial example implementation is provided.

**Parameters**:   
&nbsp;&nbsp;*irqStatus*   
&nbsp;&nbsp;&nbsp;&nbsp;The IRQ interrupt type value.
&nbsp;&nbsp;*contextHandle*   
&nbsp;&nbsp;&nbsp;&nbsp;Value identifying the context of the application that registered the callback function

**Remarks**:   
&nbsp;&nbsp;The context parameter contains the a handle to the client context, provided   
&nbsp;&nbsp;at the time the callback function was registered using the CallbackRegister function.   
&nbsp;&nbsp;This context handle value is passed back to the client as the "context" parameter.   
&nbsp;&nbsp;It can be any value (such as a pointer to the client's data) necessary to   
&nbsp;&nbsp;identify the client context or instance of the client that made the data transfer request. 

&nbsp;&nbsp;The callback function executes in the PLIB's interrupt context. It is recommended   
&nbsp;&nbsp;of the application to not perform process intensive or blocking operations with in this function.

**Example**:
```C
void APP_SPW_Handler(uintptr_t context)
{
    //Fixable error has occurred
}

SPW_CallbackRegister(&APP_SPW_Handler, (uintptr_t)NULL);
```

---

## SPW PLib Instance Object
```C
typedef struct
{
    /* Transfer Event Callback for interrupt*/
    SPW_CALLBACK callback;

    /* Transfer Event Callback Context for interrupt*/
    uintptr_t context;
} SPW_OBJ;
```
**Summary**:   
&nbsp;&nbsp;SPW PLib Object structure

**Description**:   
&nbsp;&nbsp;This data structure defines the SPW PLib Instance Object   

---

## SPW link
```C
typedef enum
{
    SPW_LINK_1 = 1,
    SPW_LINK_2 = 2,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_LINK_INVALID = 0xFFFFFFFF
} SPW_LINK;
```
**Summary**:   
&nbsp;&nbsp;Identifies the SPW link   

**Description**:   
&nbsp;&nbsp;This data type identifies the SPW link   

---

## SPW LINK status
```C
typedef enum
{
    SPW_LINK_STATUS_LINKSTATE_MASK = SPW_LINK1_STATUS_LINKSTATE_Msk, 
    SPW_LINK_STATUS_TXDEFDIV_MASK = SPW_LINK1_STATUS_TXDEFDIV_Msk,
    SPW_LINK_STATUS_TXEMPTY = SPW_LINK1_STATUS_TXEMPTY_Msk,
    SPW_LINK_STATUS_GOTNULL = SPW_LINK1_STATUS_GOTNULL_Msk,
    SPW_LINK_STATUS_GOTFCT = SPW_LINK1_STATUS_GOTFCT_Msk,
    SPW_LINK_STATUS_GOTNCHAR = SPW_LINK1_STATUS_GOTNCHAR_Msk,
    SPW_LINK_STATUS_SEEN0 = SPW_LINK1_STATUS_SEEN0_Msk, 
    SPW_LINK_STATUS_SEEN1 = SPW_LINK1_STATUS_SEEN1_Msk,
    SPW_LINK_STATUS_SEEN2 = SPW_LINK1_STATUS_SEEN2_Msk,
    SPW_LINK_STATUS_SEEN3 = SPW_LINK1_STATUS_SEEN3_Msk,
    SPW_LINK_STATUS_SEEN4 = SPW_LINK1_STATUS_SEEN4_Msk,
    SPW_LINK_STATUS_SEEN5 = SPW_LINK1_STATUS_SEEN5_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_LINK_STATUS_INVALID = 0xFFFFFFFF
} SPW_LINK_STATUS;
```

**Summary**:   
&nbsp;&nbsp;Identifies the SPW LINK current status   

**Description**:   
&nbsp;&nbsp;This data type identifies the SPW LINK status   

---

## SPW LINK state
```C
typedef enum
{
    SPW_LINK_STATE_ERROR_RESET = 0,
    SPW_LINK_STATE_ERROR_WAIT,
    SPW_LINK_STATE_READY,
    SPW_LINK_STATE_STARTED,
    SPW_LINK_STATE_CONNECTING,
    SPW_LINK_STATE_RUN,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_LINK_STATE_INVALID = 0xFFFFFFFF
} SPW_LINK_STATE;
```

**Summary**:   
&nbsp;&nbsp;Identifies the SPW LINK current CODEC link state machine   

**Description**:   
&nbsp;&nbsp;This data type identifies the SPW CODEC link state machine   

---

## SPW LINK IRQ status
```C
typedef enum
{
    SPW_LINK_INT_MASK_DISERR = SPW_LINK1_PI_RM_DISERR_Msk,
    SPW_LINK_INT_MASK_PARERR = SPW_LINK1_PI_RM_PARERR_Msk,
    SPW_LINK_INT_MASK_ESCERR = SPW_LINK1_PI_RM_ESCERR_Msk,
    SPW_LINK_INT_MASK_CRERR = SPW_LINK1_PI_RM_CRERR_Msk,
    SPW_LINK_INT_MASK_LINKABORT = SPW_LINK1_PI_RM_LINKABORT_Msk,
    SPW_LINK_INT_MASK_EEPTRANS = SPW_LINK1_PI_RM_EEPTRANS_Msk,
    SPW_LINK_INT_MASK_EEPREC = SPW_LINK1_PI_RM_EEPREC_Msk,
    SPW_LINK_INT_MASK_DISCARD = SPW_LINK1_PI_RM_DISCARD_Msk,
    SPW_LINK_INT_MASK_ESCEVENT2 = SPW_LINK1_PI_RM_ESCEVENT2_Msk,
    SPW_LINK_INT_MASK_ESCEVENT1 = SPW_LINK1_PI_RM_ESCEVENT1_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_LINK_INT_MASK_INVALID = 0xFFFFFFFF
} SPW_LINK_INT_MASK;
```

**Summary**:   
&nbsp;&nbsp;Identifies the SPW LINK IRQ event that have pending interrupt   

**Description**:   
&nbsp;&nbsp;This data type identifies the SPW LINK IRQ event that have pending interrupt   

---

## SPW PKTRX status
```C
typedef enum
{
    SPW_PKTRX_STATUS_COUNT_MASK = SPW_PKTRX1_STATUS_COUNT_Msk, 
    SPW_PKTRX_STATUS_PACKET = SPW_PKTRX1_STATUS_PACKET_Msk,
    SPW_PKTRX_STATUS_LOCKED = SPW_PKTRX1_STATUS_LOCKED_Msk,
    SPW_PKTRX_STATUS_ARM = SPW_PKTRX1_STATUS_ARM_Msk,
    SPW_PKTRX_STATUS_ACT = SPW_PKTRX1_STATUS_ACT_Msk,
    SPW_PKTRX_STATUS_PENDING = SPW_PKTRX1_STATUS_PENDING_Msk,
    SPW_PKTRX_STATUS_DEACT = SPW_PKTRX1_STATUS_DEACT_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_PKTRX_STATUS_INVALID = 0xFFFFFFFF
} SPW_PKTRX_STATUS;
```

**Summary**:   
&nbsp;&nbsp;Identifies the SPW PKTRX current status   

**Description**:   
&nbsp;&nbsp;This data type identifies the SPW PKTRX status   

---

## SPW PKTRX previous buffer status
```C
typedef enum
{
    SPW_PKTRX_PREV_STATUS_CNT_MASK = SPW_PKTRX1_PREVBUFSTS_CNT_Msk,
    SPW_PKTRX_PREV_STATUS_EEP = SPW_PKTRX1_PREVBUFSTS_EEP_Msk,
    SPW_PKTRX_PREV_STATUS_FULLI = SPW_PKTRX1_PREVBUFSTS_FULLI_Msk,
    SPW_PKTRX_PREV_STATUS_FULLD = SPW_PKTRX1_PREVBUFSTS_FULLD_Msk,
    SPW_PKTRX_PREV_STATUS_DMAERR = SPW_PKTRX1_PREVBUFSTS_DMAERR_Msk,
    SPW_PKTRX_PREV_STATUS_LOCKED = SPW_PKTRX1_PREVBUFSTS_LOCKED_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_PKTRX_PREV_STATUS_INVALID = 0xFFFFFFFF
} SPW_PKTRX_PREV_STATUS;
```

**Summary**:   
&nbsp;&nbsp;Identifies the SPW PKTRX previous buffer status   

**Description**:   
&nbsp;&nbsp;This data type identifies the SPW PKTRX previous buffer   

---

## SPW PKTRX interrupt status
```C
typedef enum
{
    SPW_PKTRX_INT_MASK_DEACT = SPW_PKTRX1_PI_R_DEACT_Msk,
    SPW_PKTRX_INT_MASK_EOP = SPW_PKTRX1_PI_R_EOP_Msk,
    SPW_PKTRX_INT_MASK_EEP = SPW_PKTRX1_PI_R_EEP_Msk,
    SPW_PKTRX_INT_MASK_DISCARD = SPW_PKTRX1_PI_R_DISCARD_Msk,
    SPW_PKTRX_INT_MASK_ACT = SPW_PKTRX1_PI_R_ACT_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_PKTRX_INT_MASK_INVALID = 0xFFFFFFFF
} SPW_PKTRX_INT_MASK;
```

**Summary**:   
&nbsp;&nbsp;Identifies the SPW PKTRX current interrupt status   

**Description**:   
&nbsp;&nbsp;This data type identifies the SPW PKTRX interrupt status   

---

## SPW PKTRX next receive buffer start condition
```C
typedef enum
{
    SPW_PKTRX_NXTBUF_START_EVENT = SPW_PKTRX1_NXTBUFCFG_START_STARTEVENT_Val, 
    SPW_PKTRX_NXTBUF_START_NOW = SPW_PKTRX1_NXTBUFCFG_START_STARTNOW_Val,
    SPW_PKTRX_NXTBUF_START_TCH1 = SPW_PKTRX1_NXTBUFCFG_START_STARTTCH1_Val,
    SPW_PKTRX_NXTBUF_START_LATER = SPW_PKTRX1_NXTBUFCFG_START_STARTLATER_Val,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_PKTRX_NXTBUF_START_INVALID = 0xFFFFFFFF
} SPW_PKTRX_NXTBUF_START;
```

**Summary**:   
&nbsp;&nbsp;Identifies the SPW PKTRX next receive buffer start condition   

**Description**:   
&nbsp;&nbsp;This data type identifies the SPW PKTRX next receive buffer start condition   

---

## SPW PKTRX packet information data
```C
typedef struct
{
    /* Word 0 */
    uint32_t Eop       :  1;
    uint32_t Eep       :  1;
    uint32_t Cont      :  1;
    uint32_t Split     :  1;
    uint32_t NotUsed1  : 12;
    uint32_t Crc       :  8;
    uint32_t NotUsed0  :  8;

    /* Word 1 */
    uint32_t DAddr     : 32;

    /* Word 2 */
    uint32_t DSize     : 24;
    uint32_t NotUsed2  :  8;

    /* Word 3 */
    uint32_t Etime     : 19;
    uint32_t NotUsed3  : 13;
} SPW_PKTRX_INFO;
```

**Summary**:   
&nbsp;&nbsp;SPW received packet information data   

**Description**:   
&nbsp;&nbsp;This data structure defines the received SPW packet information data   

---

## SPW PKTTX status
```C
typedef enum
{
    SPW_PKTTX_STATUS_ARM = SPW_PKTTX1_STATUS_ARM_Msk, 
    SPW_PKTTX_STATUS_ACT = SPW_PKTTX1_STATUS_ACT_Msk,
    SPW_PKTTX_STATUS_PENDING = SPW_PKTTX1_STATUS_PENDING_Msk,
    SPW_PKTTX_STATUS_DEACT = SPW_PKTTX1_STATUS_DEACT_Msk,
    SPW_PKTTX_STATUS_PREV_MASK = SPW_PKTTX1_STATUS_PREV_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_PKTTX_STATUS_INVALID = 0xFFFFFFFF
} SPW_PKTTX_STATUS;
```

**Summary**:   
&nbsp;&nbsp;Identifies the SPW PKTTX current status   

**Description**:   
&nbsp;&nbsp;This data type identifies the SPW PKTTX status   

---

## SPW PKTTX Previous status
```C
typedef enum
{
    SPW_PKTTX_PREV_NOINFO = 0,
    SPW_PKTTX_PREV_LASTSENDLISTOK,
    SPW_PKTTX_PREV_ABORTEDMEMERR,
    SPW_PKTTX_PREV_ABORTEDNEWSD,
    SPW_PKTTX_PREV_ABORTEDUSERCMD,
    SPW_PKTTX_PREV_ABORTEDTIMEOUT,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_PKTTX_PREV_INVALID = 0xFFFFFFFF
}SPW_PKTTX_PREV;
```

**Summary**:   
&nbsp;&nbsp;Identifies the SPW PKTTX Previous status.   

**Description**:   
&nbsp;&nbsp;This data type identifies the PKTTX Previous status.   

---

## SPW PKTTX interrupt status
```C
typedef enum
{
    SPW_PKTTX_INT_MASK_DEACT = SPW_PKTTX1_PI_R_DEACT_Msk,
    SPW_PKTTX_INT_MASK_ACT = SPW_PKTTX1_PI_R_ACT_Msk,
    SPW_PKTTX_INT_MASK_EOP = SPW_PKTTX1_PI_R_EOP_Msk,
    SPW_PKTTX_INT_MASK_EEP = SPW_PKTTX1_PI_R_EEP_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_PKTTX_INT_MASK_INVALID = 0xFFFFFFFF
}SPW_PKTTX_INT_MASK;
```
**Summary**:   
&nbsp;&nbsp;Identifies the SPW PKTTX current interrupt status   

**Description**:   
&nbsp;&nbsp;This data type identifies the SPW PKTTX interrupt status  

---

## SPW PKTTX next send list start mode
```C
typedef enum
{
    SPW_PKTTX_NXTSEND_START_EVENT = SPW_PKTTX1_NXTSENDCFG_START_STARTEVENT_Val, 
    SPW_PKTTX_NXTSEND_START_NOW = SPW_PKTTX1_NXTSENDCFG_START_STARTNOW_Val,
    SPW_PKTTX_NXTSEND_START_TCH1 = SPW_PKTTX1_NXTSENDCFG_START_STARTTCH1_Val,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_PKTTX_NXTSEND_START_INVALID = 0xFFFFFFFF
} SPW_PKTTX_NXTSEND_START;
```

**Summary**:
&nbsp;&nbsp;Identifies the SPW PKTTX next send list start mode

**Description**:
&nbsp;&nbsp;This data type identifies the SPW PKTTX next send list start mode

---

## SPW PKTTX send list entry
```C
typedef struct
{
    /* Word 0 */
    uint32_t Start      : 19;
    uint32_t NotUsed1   :  5;
    uint32_t RSize      :  4;
    uint32_t NotUsed0   :  1;
    uint32_t Entry      :  2;
    uint32_t Skip       :  1;

    /* Word 1 */
    uint32_t RB4        :  8;
    uint32_t RB3        :  8;
    uint32_t RB2        :  8;
    uint32_t RB1        :  8;

    /* Word 2 */
    uint32_t RB8        :  8;
    uint32_t RB7        :  8;
    uint32_t RB6        :  8;
    uint32_t RB5        :  8;

    /* Word 3 */
    uint32_t HSize      :  8;
    uint32_t HCrc       :  1;
    uint32_t NotUsed3   :  7;
    uint32_t EscChar    :  8;
    uint32_t EscMask    :  4;
    uint32_t NotUsed2   :  4;

    /* Word 4 */
    uint32_t HAddr      : 32;

    /* Word 5 */
    uint32_t DSize      : 24;
    uint32_t DCrc       :  1;
    uint32_t NotUsed4   :  7;

    /* Word 6 */
    uint32_t DAddr      : 32;

    /* Word 7 */    
    uint32_t TimeOut    : 19;
    uint32_t NotUsed5   : 13;
} SPW_PKTTX_SEND_LIST_ENTRY;
```

**Summary**:   
&nbsp;&nbsp;SPW send list entry   

**Description**:   
&nbsp;&nbsp;This data structure defines a SPW send list entry   

---

## SPW RMAP status
```C
typedef enum
{
    SPW_RMAP_STATUS_ERRCODE_MASK = SPW_RMAP1_STS_RC_ERRCODE_Msk, 
    SPW_RMAP_STATUS_VALID = SPW_RMAP1_STS_RC_VALID_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_RMAP_STATUS_INVALID = 0xFFFFFFFF
} SPW_RMAP_STATUS;
```

**Summary**:   
&nbsp;&nbsp;Identifies the SPW RMAP current status   

**Description**:   
&nbsp;&nbsp;This data type identifies the SPW RMAP status   

---

## SPW RMAP Error Code
```C
typedef enum
{
    /* No error detected */
    SPW_RMAP_ERRCODE_NOERROR = SPW_RMAP1_STS_RC_ERRCODE_NOERROR_Val,
    /* Error while DMA accessing the internal bus, e.g. illegal address. */
    SPW_RMAP_ERRCODE_DMAERROR = SPW_RMAP1_STS_RC_ERRCODE_DMAERROR_Val,
    /* Unused RMAP command according to [RMAP] */
    SPW_RMAP_ERRCODE_RMAPERROR = SPW_RMAP1_STS_RC_ERRCODE_RMAPERROR_Val,
    /* Destination key error */
    SPW_RMAP_ERRCODE_DESTKEYERROR = SPW_RMAP1_STS_RC_ERRCODE_DESTKEYERROR_Val,
    /* Data CRC error */
    SPW_RMAP_ERRCODE_DATACRCERROR = SPW_RMAP1_STS_RC_ERRCODE_DATACRCERROR_Val,
    /* Early EOP in header or data, i.e. EOP has been received with less data than expected from the RMAP command header. */
    SPW_RMAP_ERRCODE_EOPERROR = SPW_RMAP1_STS_RC_ERRCODE_EOPERROR_Val,
    /* Cargo too large. Late EOP or EEP in data, i.e. EOP/EEP has been received with more data than expected from the RMAP command header. */
    SPW_RMAP_ERRCODE_CARGOERROR = SPW_RMAP1_STS_RC_ERRCODE_CARGOERROR_Val,
    /* Early EEP in data for RMAP commands. EEP has been received with less data or exactly as much as expected from the RMAP command header. */
    SPW_RMAP_ERRCODE_EEPERROR = SPW_RMAP1_STS_RC_ERRCODE_EEPERROR_Val,
    /* Authorisation error:Invalid or unsupported command. */
    SPW_RMAP_ERRCODE_CMDERROR = SPW_RMAP1_STS_RC_ERRCODE_CMDERROR_Val,
    /* Non-matching Target Logical Address. */
    SPW_RMAP_ERRCODE_TLAERROR = SPW_RMAP1_STS_RC_ERRCODE_TLAERROR_Val,
    /* Incorrect header CRC. */
    SPW_RMAP_ERRCODE_HEADERCRCERROR = SPW_RMAP1_STS_RC_ERRCODE_HEADERCRCERROR_Val,
    /* Protocol Identifier not supported. */
    SPW_RMAP_ERRCODE_PROTOCOLIDERROR = SPW_RMAP1_STS_RC_ERRCODE_PROTOCOLIDERROR_Val,
    /* Unsupported reply address length */
    SPW_RMAP_ERRCODE_REPLYADDERROR = SPW_RMAP1_STS_RC_ERRCODE_REPLYADDERROR_Val,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_RMAP_ERRCODE_INVALID = 0xFFFFFFFF
} SPW_RMAP_ERRCODE;
```

**Summary**:   
&nbsp;&nbsp;Identifies the SPW RMAP Error Code   

**Description**:   
&nbsp;&nbsp;This data type identifies the SPW RMAP Error Code

---

## SPW ROUTER table physical address
```C
typedef enum
{
    SPW_ROUTER_PHYS_ADDR_DISABLE = 0,
    SPW_ROUTER_PHYS_ADDR_LINK_1 = SPW_ROUTER_LINK1_PORT,
    SPW_ROUTER_PHYS_ADDR_LINK_2 = SPW_ROUTER_LINK2_PORT,
    SPW_ROUTER_PHYS_ADDR_PKTRX = SPW_ROUTER_PKTRX_PORT,
    SPW_ROUTER_PHYS_ADDR_RMAP = SPW_ROUTER_RMAP_PORT,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_ROUTER_PHYS_ADDR_INVALID = 0xFFFFFFFF
} SPW_ROUTER_PHYS_ADDR;
```

**Summary**:   
&nbsp;&nbsp;Identifies the SPW ROUTER table physical address   

**Description**:   
&nbsp;&nbsp;This data type identifies the SPW ROUTER table physical address   

---

## SPW ROUTER status
```C
typedef enum
{
    SPW_ROUTER_STATUS_DEST_MASK = SPW_ROUTER_STS_DEST_Msk, 
    SPW_ROUTER_STATUS_SOURCE_MASK = SPW_ROUTER_STS_SOURCE_Msk,
    SPW_ROUTER_STATUS_BYTE_MASK = SPW_ROUTER_STS_BYTE_Msk,
    SPW_ROUTER_STATUS_COUNT_MASK = SPW_ROUTER_STS_COUNT_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_ROUTER_STATUS_INVALID = 0xFFFFFFFF
} SPW_ROUTER_STATUS;
```

**Summary**:   
&nbsp;&nbsp;Identifies the SPW ROUTER current status   

**Description**:   
&nbsp;&nbsp;This data type identifies the SPW ROUTER status   

---

## SPW ROUTER Timeout status
```C
typedef enum
{
    SPW_ROUTER_TIMEOUT_STATUS_ADDR_MASK = SPW_ROUTER_TIMEOUT_ADDR_Msk, 
    SPW_ROUTER_TIMEOUT_STATUS_LOCKED = SPW_ROUTER_TIMEOUT_LOCKED_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_ROUTER_TIMEOUT_STATUS_INVALID = 0xFFFFFFFF
} SPW_ROUTER_TIMEOUT_STATUS;
```

**Summary**:   
&nbsp;&nbsp;Identifies the SPW ROUTER Timeout current status   

**Description**:   
&nbsp;&nbsp;This data type identifies the SPW ROUTER Timeout status   

---

## SPW_Initialize
```C
void SPW_Initialize(void)
```

**Summary**:   
&nbsp;&nbsp;Initializes given instance of the SPW peripheral   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_LINK_Initialize
```C
void SPW_LINK_Initialize(void)
```

**Summary**:   
&nbsp;&nbsp;Initialize LINK modules of the SPW peripheral   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_RMAP_Initialize
```C
void SPW_RMAP_Initialize(void)
```

**Summary**:   
&nbsp;&nbsp;Initialize RMAP modules of the SPW peripheral   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_ROUTER_Initialize
```C
void SPW_ROUTER_Initialize(void)
```

**Summary**:   
&nbsp;&nbsp;Initialize ROUTER modules of the SPW peripheral   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_CallbackRegister
```C
void SPW_CallbackRegister(SPW_CALLBACK callback, uintptr_t contextHandle)
```

**Summary**:   
&nbsp;&nbsp;Sets the pointer to the function (and it's context) to be called when the   
&nbsp;&nbsp;given SPW's interrupt events occur   

**Description**:
&nbsp;&nbsp;This function sets the pointer to a client function to be called "back" when   
&nbsp;&nbsp;the given SPW's interrupt events occur. It also passes a context value    
&nbsp;&nbsp;(usually a pointer to a context structure) that is passed into the function   
&nbsp;&nbsp;when it is called. The specified callback function will be called from the   
&nbsp;&nbsp;peripheral interrupt context   

**Precondition**:   
&nbsp;&nbsp;SPW_Initialize must have been called for the associated   
&nbsp;&nbsp;SPW instance   

**Parameters**:   
&nbsp;&nbsp;*callback*   
&nbsp;&nbsp;&nbsp;&nbsp;A pointer to a function with a calling signature defined by the SPW_CALLBACK   
&nbsp;&nbsp;&nbsp;&nbsp;data type. Setting this to NULL disables the callback feature   
&nbsp;&nbsp;*contextHandle*   
&nbsp;&nbsp;&nbsp;&nbsp;A value (usually a pointer) passed (unused) into the function identified by   
&nbsp;&nbsp;&nbsp;&nbsp;the callback parameter   

**Returns**:   
&nbsp;&nbsp;None   

**Remarks**:   
&nbsp;&nbsp;None

---

## SPW_LINK_InterruptEnable
```C
void SPW_LINK_InterruptEnable(SPW_LINK link, SPW_LINK_INT_MASK interruptMask)
```
**Summary**:   
&nbsp;&nbsp;Enables SPW LINK Interrupt for given link interface   

**Precondition**:   
&nbsp;&nbsp;SPW_Initialize must have been called for the associated SPW instance   

**Parameters**:   
&nbsp;&nbsp;*link*   
&nbsp;&nbsp;&nbsp;&nbsp;The selected link ID   
&nbsp;&nbsp;*interruptMask*   
&nbsp;&nbsp;&nbsp;&nbsp;Interrupt to be enabled   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_LINK_InterruptDisable
```C
void SPW_LINK_InterruptDisable(SPW_LINK link, SPW_LINK_INT_MASK interruptMask)
```

**Summary**:   
&nbsp;&nbsp;Disables SPW LINK Interrupt for given link interface   

**Precondition**:   
&nbsp;&nbsp;SPW_Initialize must have been called for the associated SPW instance   

**Parameters**:   
&nbsp;&nbsp;*link*   
&nbsp;&nbsp;&nbsp;&nbsp;The selected link ID   
&nbsp;&nbsp;*InterruptMask*   
&nbsp;&nbsp;&nbsp;&nbsp;Interrupt to be disabled   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_PKTRX_SetDiscard
```C
void SPW_PKTRX_SetDiscard(bool discard)
```

**Summary**:   
&nbsp;&nbsp;Set the SPW packet RX inactive incoming mode to discard or stall option   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;*discard*   
&nbsp;&nbsp;&nbsp;&nbsp;True for discard mode, false for stall mode   

**Returns**:   
&nbsp;&nbsp;None.   

**Notes**:   
&nbsp;&nbsp;- The discard mode is not working with SAMRH71F20C device   
&nbsp;&nbsp;- It will always stall by defaut, see ErrataSheet

---

## SPW_PKTRX_SetNextBuffer
```C
void SPW_PKTRX_SetNextBuffer(
        uint8_t* dataAddress,
        uint32_t dataLengthBytes,
        SPW_PKTRX_INFO* packetInfoAddress,
        uint16_t pckCount,
        bool split,
        SPW_PKTRX_NXTBUF_START startMode,
        uint8_t startValue)
```

**Summary**:   
&nbsp;&nbsp;Set the SPW next receive buffer informations and start conditions   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;*dataAddress*   
&nbsp;&nbsp;&nbsp;&nbsp;pointer to data buffer address   
&nbsp;&nbsp;*dataLengthBytes*   
&nbsp;&nbsp;&nbsp;&nbsp;length in byte of the data buffer address   
&nbsp;&nbsp;*packetInfoAddress*   
&nbsp;&nbsp;&nbsp;&nbsp;pointer to the packet info type address were packet information will be stored   
&nbsp;&nbsp;*pckCount*   
&nbsp;&nbsp;&nbsp;&nbsp;maximum number of entries in packet info buffer   
&nbsp;&nbsp;*split*   
&nbsp;&nbsp;&nbsp;&nbsp;set to True if any ongoing packet should be split when the start condition is met   
&nbsp;&nbsp;*startMode*   
&nbsp;&nbsp;&nbsp;&nbsp;receive buffer start mode condition   
&nbsp;&nbsp;*startValue*   
&nbsp;&nbsp;&nbsp;&nbsp;Matching value for event start condition   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_PKTRX_InterruptEnable
```C
void SPW_PKTRX_InterruptEnable(SPW_PKTRX_INT_MASK interruptMask)
```

**Summary**:   
&nbsp;&nbsp;Enables SPW RX module Interrupt   

**Precondition**:   
&nbsp;&nbsp;SPW_Initialize must have been called for the associated SPW instance   

**Parameters**:   
&nbsp;&nbsp;*interruptMask*   
&nbsp;&nbsp;&nbsp;&nbsp;Interrupt to be enabled   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_PKTRX_InterruptDisable
```C
void SPW_PKTRX_InterruptDisable(SPW_PKTRX_INT_MASK interruptMask)
```

**Summary**:   
&nbsp;&nbsp;Disables SPW RX module Interrupt   

**Precondition**:   
&nbsp;&nbsp;SPW_Initialize must have been called for the associated SPW instance   

**Parameters**:   
&nbsp;&nbsp;*interruptMask*   
&nbsp;&nbsp;&nbsp;&nbsp;Interrupt to be disabled   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_PKTRX_CurrentPacketAbort
```C
void SPW_PKTRX_CurrentPacketAbort(void)
```

**Summary**:   
&nbsp;&nbsp;Immediately abort and discard any ongoing SPW packet in RX module   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_PKTRX_CurrentPacketSplit
```C
void SPW_PKTRX_CurrentPacketSplit(void);
```

**Summary**:   
&nbsp;&nbsp;Immediately split any ongoing SPW packet in RX module   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_PKTTX_InterruptEnable
```C
void SPW_PKTTX_InterruptEnable(SPW_PKTTX_INT_MASK interruptMask)
```

**Summary**:   
&nbsp;&nbsp;Enables SPW TX module Interrupt   

**Precondition**:   
&nbsp;&nbsp;SPW_Initialize must have been called for the associated SPW instance   

**Parameters**:   
&nbsp;&nbsp;*interruptMask*   
&nbsp;&nbsp;&nbsp;&nbsp;Interrupt to be enabled   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_PKTTX_InterruptDisable
```C
void SPW_PKTTX_InterruptDisable(SPW_PKTTX_INT_MASK interruptMask)
```

**Summary**:   
&nbsp;&nbsp;Disables SPW TX module Interrupt   

**Precondition**:   
&nbsp;&nbsp;SPW_Initialize must have been called for the associated SPW instance   

**Parameters**:   
&nbsp;&nbsp;*interruptMask*   
&nbsp;&nbsp;&nbsp;&nbsp;Interrupt to be disabled   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_PKTTX_SetNextSendList
```C
void SPW_PKTTX_SetNextSendList(uint8_t* routerBytesTable,
                               SPW_PKTTX_SEND_LIST_ENTRY* sendListAddress,
                               uint16_t length,
                               bool abort,
                               SPW_PKTTX_NXTSEND_START startMode,
                               uint8_t startValue)
```

**Summary**:   
&nbsp;&nbsp;Set the SPW next send list informations and start conditions   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;*routerBytesTable*   
&nbsp;&nbsp;&nbsp;&nbsp;Table of 4 router bytes to prepend (if non-zero) to each   
&nbsp;&nbsp;&nbsp;&nbsp;packets in the send list. All bytes are set to 0 if this pointer is NULL   
&nbsp;&nbsp;*sendListAddress*   
&nbsp;&nbsp;&nbsp;&nbsp;Pointer to the send list type object that will be transmitted   
&nbsp;&nbsp;*length*   
&nbsp;&nbsp;&nbsp;&nbsp;Number of entries in send list   
&nbsp;&nbsp;*abort*   
&nbsp;&nbsp;&nbsp;&nbsp;Set to True if any ongoing send list should be abort when this send list wants to start   
&nbsp;&nbsp;*startMode*   
&nbsp;&nbsp;&nbsp;&nbsp;Send list start mode condition   
&nbsp;&nbsp;*startValue*   
&nbsp;&nbsp;Matching value for event start condition   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_PKTTX_UnlockStatus
```C
void SPW_PKTTX_UnlockStatus(void)
```

**Summary**:   
&nbsp;&nbsp;Unlock the SPW TX module previous buffer status   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_ROUTER_TimeoutDisable
```C
void SPW_ROUTER_TimeoutDisable(bool disable)
```

**Summary**:   
&nbsp;&nbsp;Disable SPW ROUTER timeout event   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;*disable*   
&nbsp;&nbsp;&nbsp;&nbsp;if true, Router timeout event is disabled. Enabled if false   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_ROUTER_LogicalAddressRoutingEnable
```C
void SPW_ROUTER_LogicalAddressRoutingEnable(bool enable)
```

**Summary**:   
&nbsp;&nbsp;Enable SPW ROUTER Logical Address Routing   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;enable   
&nbsp;&nbsp;&nbsp;&nbsp;if true, Router Logical Address Routing is enable. Disabled if false   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_ROUTER_FallbackEnable
```C
void SPW_ROUTER_FallbackEnable(bool enable)
```

**Summary**:   
&nbsp;&nbsp;Enable SPW ROUTER Fallback   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;*enable*   
&nbsp;&nbsp;&nbsp;&nbsp;if true, Router Fallback is enable. Disabled if false   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_ROUTER_RoutingTableEntrySet
```C
void SPW_ROUTER_RoutingTableEntrySet(uint8_t logicalAddress, bool delHeader, uint8_t physicalAddress)
```

**Summary**:   
&nbsp;&nbsp;Set a SPW routing table entry for a logical address   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;*logicalAddress*   
&nbsp;&nbsp;&nbsp;&nbsp;Logical address entry to configure between 32 to 255   
&nbsp;&nbsp;*delHeader*   
&nbsp;&nbsp;&nbsp;&nbsp;if true, discard router byte for this logical address   
&nbsp;&nbsp;*physicalAddress*   
&nbsp;&nbsp;&nbsp;&nbsp;The physical address were incoming packet will be routed   

**Returns**:   
&nbsp;&nbsp;None

---

## SPW_LINK_StatusGet
```C
SPW_LINK_STATUS SPW_LINK_StatusGet(SPW_LINK link)
```

**Summary**:
&nbsp;&nbsp;Get the SPW LINK status of the given SPW link

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;*link*   
&nbsp;&nbsp;&nbsp;&nbsp;the selected link ID   

**Returns**:   
&nbsp;&nbsp;Current status of the selected SPW link

---

## SPW_LINK_IrqStatusGetMaskedAndClear
```C
SPW_LINK_INT_MASK SPW_LINK_IrqStatusGetMaskedAndClear(SPW_LINK link)
```

**Summary**:   
&nbsp;&nbsp;Get the SPW LINK interrupt status for masked interrupt and clear them for the   
&nbsp;&nbsp;selected link interface   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;*link*   
&nbsp;&nbsp;&nbsp;&nbsp;The selected link ID   

**Returns**:   
&nbsp;&nbsp;Current interrupt status of the selected link

---

## SPW_PKTRX_StatusGet
```C
SPW_PKTRX_STATUS SPW_PKTRX_StatusGet(void)
```

**Summary**:   
&nbsp;&nbsp;Get the SPW packet RX module status   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Current status of SPW packet RX module

---

## SPW_PKTRX_IrqStatusGetMaskedAndClear
```C
SPW_PKTRX_INT_MASK SPW_PKTRX_IrqStatusGetMaskedAndClear(void)
```

**Summary**:   
&nbsp;&nbsp;Get the SPW packet RX module interrupt status for masked interrupt and clear them   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Current interrupt status of SPW packet RX module

---

## SPW_PKTRX_GetPreviousBufferStatus
```C
SPW_PKTRX_PREV_STATUS SPW_PKTRX_GetPreviousBufferStatus(void)
```

**Summary**:   
&nbsp;&nbsp;Get the previous buffer status of SPW packet RX module   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Current value of previous buffer status of SPW packet RX module

---

## SPW_PKTTX_StatusGet
```C
SPW_PKTTX_STATUS SPW_PKTTX_StatusGet(void)
```

**Summary**:   
&nbsp;&nbsp;Get the SPW packet TX module status   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Current status of SPW packet TX module

---

## SPW_PKTTX_IrqStatusGetMaskedAndClear
```C
SPW_PKTTX_INT_MASK SPW_PKTTX_IrqStatusGetMaskedAndClear(void);
```

**Summary**:   
&nbsp;&nbsp;Get the SPW packet TX module interrupt status for masked interrupt and clear them   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Current interrupt status of SPW packet TX module

---

## SPW_RMAP_StatusGetAndClear
```C
SPW_RMAP_STATUS SPW_RMAP_StatusGetAndClear(void)
```

**Summary**:   
&nbsp;&nbsp;Get SPW RMAP Status and clear   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;SPW RMAP Status   

---

## SPW_ROUTER_StatusGet
```C
SPW_ROUTER_STATUS SPW_ROUTER_StatusGet(void)
```

**Summary**:   
&nbsp;&nbsp;Get SPW ROUTER Status   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;SPW ROUTER Status

---

## SPW_ROUTER_TimeoutStatusGet
```C
SPW_ROUTER_TIMEOUT_STATUS SPW_ROUTER_TimeoutStatusGet(void)
```

**Summary**:   
&nbsp;&nbsp;Get SPW ROUTER Timeout Status   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;SPW ROUTER Timeout Status




