---
grand_parent: Peripheral libraries
parent: SPW Peripheral Library
title: SPW Peripheral Library Interface
has_children: false
has_toc: true
nav_order: 2
---

# Peripheral Library Interface
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Data Types and Constants

### SPW IRQ status

```c
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

**Summary**

Identifies the SPW IRQ lines that have pending interrupt

**Description**

This data type identifies the SPW IRQ lines that have pending interrupt

---

### SPW Callback

```c
typedef void (*SPW_CALLBACK) (SPW_INT_MASK irqStatus, uintptr_t contextHandle)
```

**Summary**

SPW Callback Function Pointer.

**Description**

This data type defines the required function signature for the SPW callback function. Application must register a pointer to a callback function whose function signature (parameter and return value types) match the types specified by this function pointer in order to receive callback from the PLIB.
The parameters and return values are described here and a partial example implementation is provided.

**Parameters**

*irqStatus* The IRQ interrupt type value.
*contextHandle* Value identifying the context of the application that registered the callback function

**Remarks**

The context parameter contains the a handle to the client context, provided at the time the callback function was registered using the CallbackRegister function. This context handle value is passed back to the client as the "context" parameter. It can be any value (such as a pointer to the client's data) necessary to identify the client context or instance of the client that made the data transfer request.

The callback function executes in the PLIB's interrupt context. It is recommended of the application to not perform process intensive or blocking operations with in this function.

**Example**

```c
void APP_SPW_Handler(uintptr_t context)
{
    //Fixable error has occurred
}

SPW_CallbackRegister(&APP_SPW_Handler, (uintptr_t)NULL);
```

---

### SPW PLib Instance Object

```c
typedef struct
{
    /* Transfer Event Callback for interrupt*/
    SPW_CALLBACK callback;

    /* Transfer Event Callback Context for interrupt*/
    uintptr_t context;
} SPW_OBJ;
```

**Summary**

SPW PLib Object structure

**Description**

This data structure defines the SPW PLib Instance Object

---

### SPW link

```c
typedef enum
{
    SPW_LINK_1 = 1,
    SPW_LINK_2 = 2,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_LINK_INVALID = 0xFFFFFFFF
} SPW_LINK;
```

**Summary**

Identifies the SPW link

**Description**

This data type identifies the SPW link

---

### SPW LINK status

```c
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

**Summary**

Identifies the SPW LINK current status

**Description**

This data type identifies the SPW LINK status

---

### SPW LINK state

```c
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

**Summary**

Identifies the SPW LINK current CODEC link state machine

**Description**

This data type identifies the SPW CODEC link state machine

---

### SPW LINK IRQ status

```c
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

**Summary**

Identifies the SPW LINK IRQ event that have pending interrupt

**Description**

This data type identifies the SPW LINK IRQ event that have pending interrupt

---

### SPW PKTRX status

```c
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

**Summary**

Identifies the SPW PKTRX current status

**Description**

This data type identifies the SPW PKTRX status

---

### SPW PKTRX previous buffer status

```c
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

**Summary**

Identifies the SPW PKTRX previous buffer status

**Description**

This data type identifies the SPW PKTRX previous buffer

---

### SPW PKTRX interrupt status

```c
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

**Summary**

Identifies the SPW PKTRX current interrupt status

**Description**

This data type identifies the SPW PKTRX interrupt status

---

### SPW PKTRX next receive buffer start condition

```c
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

**Summary**

Identifies the SPW PKTRX next receive buffer start condition

**Description**

This data type identifies the SPW PKTRX next receive buffer start condition

---

### SPW PKTRX packet information data

```c
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

**Summary**

SPW received packet information data

**Description**

This data structure defines the received SPW packet information data

---

### SPW PKTTX status

```c
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

**Summary**

Identifies the SPW PKTTX current status

**Description**

This data type identifies the SPW PKTTX status

---

### SPW PKTTX Previous status

```c
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
} SPW_PKTTX_PREV;
```

**Summary**

Identifies the SPW PKTTX Previous status.

**Description**

This data type identifies the PKTTX Previous status.

---

### SPW PKTTX interrupt status

```c
typedef enum
{
    SPW_PKTTX_INT_MASK_DEACT = SPW_PKTTX1_PI_R_DEACT_Msk,
    SPW_PKTTX_INT_MASK_ACT = SPW_PKTTX1_PI_R_ACT_Msk,
    SPW_PKTTX_INT_MASK_EOP = SPW_PKTTX1_PI_R_EOP_Msk,
    SPW_PKTTX_INT_MASK_EEP = SPW_PKTTX1_PI_R_EEP_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_PKTTX_INT_MASK_INVALID = 0xFFFFFFFF
} SPW_PKTTX_INT_MASK;
```

**Summary**

Identifies the SPW PKTTX current interrupt status

**Description**

This data type identifies the SPW PKTTX interrupt status

---

### SPW PKTTX next send list start mode

```c
typedef enum
{
    SPW_PKTTX_NXTSEND_START_EVENT = SPW_PKTTX1_NXTSENDCFG_START_STARTEVENT_Val,
    SPW_PKTTX_NXTSEND_START_NOW = SPW_PKTTX1_NXTSENDCFG_START_STARTNOW_Val,
    SPW_PKTTX_NXTSEND_START_TCH1 = SPW_PKTTX1_NXTSENDCFG_START_STARTTCH1_Val,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_PKTTX_NXTSEND_START_INVALID = 0xFFFFFFFF
} SPW_PKTTX_NXTSEND_START;
```

**Summary**

Identifies the SPW PKTTX next send list start mode

**Description**

This data type identifies the SPW PKTTX next send list start mode

---

### SPW PKTTX send list entry

```c
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

**Summary**

SPW send list entry

**Description**

This data structure defines a SPW send list entry

---

### SPW RMAP status

```c
typedef enum
{
    SPW_RMAP_STATUS_ERRCODE_MASK = SPW_RMAP1_STS_RC_ERRCODE_Msk,
    SPW_RMAP_STATUS_VALID = SPW_RMAP1_STS_RC_VALID_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_RMAP_STATUS_INVALID = 0xFFFFFFFF
} SPW_RMAP_STATUS;
```

**Summary**

Identifies the SPW RMAP current status

**Description**

This data type identifies the SPW RMAP status

---

### SPW RMAP Error Code

```c
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

**Summary**

Identifies the SPW RMAP Error Code

**Description**

This data type identifies the SPW RMAP Error Code

---

### SPW ROUTER table physical address

```c
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

**Summary**

Identifies the SPW ROUTER table physical address

**Description**

This data type identifies the SPW ROUTER table physical address

---

### SPW ROUTER status

```c
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

**Summary**

Identifies the SPW ROUTER current status

**Description**

This data type identifies the SPW ROUTER status

---

### SPW ROUTER Timeout status

```c
typedef enum
{
    SPW_ROUTER_TIMEOUT_STATUS_ADDR_MASK = SPW_ROUTER_TIMEOUT_ADDR_Msk,
    SPW_ROUTER_TIMEOUT_STATUS_LOCKED = SPW_ROUTER_TIMEOUT_LOCKED_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_ROUTER_TIMEOUT_STATUS_INVALID = 0xFFFFFFFF
} SPW_ROUTER_TIMEOUT_STATUS;
```

**Summary**

Identifies the SPW ROUTER Timeout current status

**Description**

This data type identifies the SPW ROUTER Timeout status

---

## Initialization functions

### SPW_Initialize

```c
void SPW_Initialize(void)
```

**Summary**

Initializes given instance of the SPW peripheral

**Preconditions**

None

**Parameters**

None

**Returns**

None

---

### SPW_LINK_Initialize

```c
void SPW_LINK_Initialize(void)
```

**Summary**

Initialize LINK modules of the SPW peripheral

**Preconditions**

None

**Parameters**

None

**Returns**

None

---

### SPW_RMAP_Initialize

```c
void SPW_RMAP_Initialize(void)
```

**Summary**

Initialize RMAP modules of the SPW peripheral

**Preconditions**

None

**Parameters**

None

**Returns**

None

---

### SPW_ROUTER_Initialize

```c
void SPW_ROUTER_Initialize(void)
```

**Summary**

Initialize ROUTER modules of the SPW peripheral

**Preconditions**

None

**Parameters**

None

**Returns**

None

---

## Setup functions

### SPW_CallbackRegister

```c
void SPW_CallbackRegister(SPW_CALLBACK callback, uintptr_t contextHandle)
```

**Summary**

Sets the pointer to the function (and it's context) to be called when the given SPW's interrupt events occurs.

**Description**

This function sets the pointer to a client function to be called "back" when the given SPW's interrupt events occurs. It also passes a context value (usually a pointer to a context structure) that is passed into the function when it is called. The specified callback function will be called from the peripheral interrupt context

**Preconditions**

SPW_Initialize must have been called for the associated SPW instance

**Parameters**

*callback* A pointer to a function with a calling signature defined by the SPW_CALLBACK data type. Setting this to NULL disables the callback feature
*contextHandle* A value (usually a pointer) passed (unused) into the function identified by the callback parameter

**Returns**

None

**Remarks**

None

---

### SPW_LINK_InterruptEnable

```c
void SPW_LINK_InterruptEnable(SPW_LINK link, SPW_LINK_INT_MASK interruptMask)
```

**Summary**

Enables SPW LINK Interrupt for given link interface

**Preconditions**

SPW_Initialize must have been called for the associated SPW instance

**Parameters**

*link* The selected link ID
*interruptMask* Interrupt to be enabled

**Returns**

None

---

### SPW_LINK_InterruptDisable

```c
void SPW_LINK_InterruptDisable(SPW_LINK link, SPW_LINK_INT_MASK interruptMask)
```

**Summary**

Disables SPW LINK Interrupt for given link interface

**Preconditions**

SPW_Initialize must have been called for the associated SPW instance

**Parameters**

*link* The selected link ID
*InterruptMask* Interrupt to be disabled

**Returns**

None

---

### SPW_PKTRX_SetDiscard

```c
void SPW_PKTRX_SetDiscard(bool discard)
```

**Summary**

Set the SPW packet RX inactive incoming mode to discard or stall option

**Preconditions**

None

**Parameters**

*discard* True for discard mode, false for stall mode

**Returns**

None.

**Notes**:

- The discard mode is not working with SAMRH71F20C device
- It will always stall by defaut, see ErrataSheet

---

### SPW_PKTRX_SetNextBuffer

```c
void SPW_PKTRX_SetNextBuffer(
        uint8_t* dataAddress,
        uint32_t dataLengthBytes,
        SPW_PKTRX_INFO* packetInfoAddress,
        uint16_t pckCount,
        bool split,
        SPW_PKTRX_NXTBUF_START startMode,
        uint8_t startValue)
```

**Summary**

Set the SPW next receive buffer informations and start conditions

**Preconditions**

None

**Parameters**

*dataAddress* pointer to data buffer address
*dataLengthBytes* length in byte of the data buffer address
*packetInfoAddress* pointer to the packet info type address were packet information will be stored
*pckCount* maximum number of entries in packet info buffer
*split* set to True if any ongoing packet should be split when the start condition is met
*startMode* receive buffer start mode condition
*startValue* Matching value for event start condition

**Returns**

None

---

### SPW_PKTRX_InterruptEnable

```c
void SPW_PKTRX_InterruptEnable(SPW_PKTRX_INT_MASK interruptMask)
```

**Summary**

Enables SPW RX module Interrupt

**Preconditions**

SPW_Initialize must have been called for the associated SPW instance

**Parameters**

*interruptMask* Interrupt to be enabled

**Returns**

None

---

### SPW_PKTRX_InterruptDisable

```c
void SPW_PKTRX_InterruptDisable(SPW_PKTRX_INT_MASK interruptMask)
```

**Summary**

Disables SPW RX module Interrupt

**Preconditions**

SPW_Initialize must have been called for the associated SPW instance

**Parameters**

*interruptMask* Interrupt to be disabled

**Returns**

None

---

### SPW_PKTRX_CurrentPacketAbort

```c
void SPW_PKTRX_CurrentPacketAbort(void)
```

**Summary**

Immediately abort and discard any ongoing SPW packet in RX module

**Preconditions**

None

**Parameters**

None

**Returns**

None

---

### SPW_PKTRX_CurrentPacketSplit

```c
void SPW_PKTRX_CurrentPacketSplit(void);
```

**Summary**

Immediately split any ongoing SPW packet in RX module

**Preconditions**

None

**Parameters**

None

**Returns**

None

---

### SPW_PKTTX_InterruptEnable

```c
void SPW_PKTTX_InterruptEnable(SPW_PKTTX_INT_MASK interruptMask)
```

**Summary**

Enables SPW TX module Interrupt

**Preconditions**

SPW_Initialize must have been called for the associated SPW instance

**Parameters**

*interruptMask* Interrupt to be enabled

**Returns**

None

---

### SPW_PKTTX_InterruptDisable

```c
void SPW_PKTTX_InterruptDisable(SPW_PKTTX_INT_MASK interruptMask)
```

**Summary**

Disables SPW TX module Interrupt

**Preconditions**

SPW_Initialize must have been called for the associated SPW instance

**Parameters**

*interruptMask* Interrupt to be disabled

**Returns**

None

---

### SPW_PKTTX_SetNextSendList

```c
void SPW_PKTTX_SetNextSendList(uint8_t* routerBytesTable,
                               SPW_PKTTX_SEND_LIST_ENTRY* sendListAddress,
                               uint16_t length,
                               bool abort,
                               SPW_PKTTX_NXTSEND_START startMode,
                               uint8_t startValue)
```

**Summary**

Set the SPW next send list informations and start conditions

**Preconditions**

None

**Parameters**

*routerBytesTable* Table of 4 router bytes to prepend (if non-zero) to each packets in the send list. All bytes are set to 0 if this pointer is NULL
*sendListAddress* Pointer to the send list type object that will be transmitted
*length* Number of entries in send list
*abort* Set to True if any ongoing send list should be abort when this send list wants to start
*startMode* Send list start mode condition
*startValue* Matching value for event start condition

**Returns**

None

---

### SPW_PKTTX_UnlockStatus

```c
void SPW_PKTTX_UnlockStatus(void)
```

**Summary**

Unlock the SPW TX module previous buffer status

**Preconditions**

None

**Parameters**

None

**Returns**

None

---

### SPW_ROUTER_TimeoutDisable

```c
void SPW_ROUTER_TimeoutDisable(bool disable)
```

**Summary**

Disable SPW ROUTER timeout event

**Preconditions**

None

**Parameters**

*disable* if true, Router timeout event is disabled. Enabled if false

**Returns**

None

---

### SPW_ROUTER_LogicalAddressRoutingEnable

```c
void SPW_ROUTER_LogicalAddressRoutingEnable(bool enable)
```

**Summary**

Enable SPW ROUTER Logical Address Routing

**Preconditions**

None

**Parameters**

*enable* if true, Router Logical Address Routing is enable. Disabled if false

**Returns**

None

---

### SPW_ROUTER_FallbackEnable

```c
void SPW_ROUTER_FallbackEnable(bool enable)
```

**Summary**

Enable SPW ROUTER Fallback

**Preconditions**

None

**Parameters**

*enable* if true, Router Fallback is enable. Disabled if false

**Returns**

None

---

### SPW_ROUTER_RoutingTableEntrySet

```c
void SPW_ROUTER_RoutingTableEntrySet(uint8_t logicalAddress, bool delHeader, uint8_t physicalAddress)
```

**Summary**

Set a SPW routing table entry for a logical address

**Preconditions**

None

**Parameters**

*logicalAddress* Logical address entry to configure between 32 to 255
*delHeader* if true, discard router byte for this logical address
*physicalAddress* The physical address were incoming packet will be routed

**Returns**

None

## Status functions

### SPW_LINK_StatusGet

```c
SPW_LINK_STATUS SPW_LINK_StatusGet(SPW_LINK link)
```

**Summary**

Get the SPW LINK status of the given SPW link

**Preconditions**

None

**Parameters**

*link* the selected link ID

**Returns**
Current status of the selected SPW link

---

### SPW_LINK_IrqStatusGetMaskedAndClear

```c
SPW_LINK_INT_MASK SPW_LINK_IrqStatusGetMaskedAndClear(SPW_LINK link)
```

**Summary**

Get the SPW LINK interrupt status for masked interrupt and clear them for the
selected link interface

**Preconditions**

None

**Parameters**

*link*
The selected link ID

**Returns**

Current interrupt status of the selected link

---

### SPW_PKTRX_StatusGet

```c
SPW_PKTRX_STATUS SPW_PKTRX_StatusGet(void)
```

**Summary**

Get the SPW packet RX module status

**Preconditions**

None

**Parameters**

None

**Returns**

Current status of SPW packet RX module

---

### SPW_PKTRX_IrqStatusGetMaskedAndClear

```c
SPW_PKTRX_INT_MASK SPW_PKTRX_IrqStatusGetMaskedAndClear(void)
```

**Summary**

Get the SPW packet RX module interrupt status for masked interrupt and clear them

**Preconditions**

None

**Parameters**

None

**Returns**

Current interrupt status of SPW packet RX module

---

### SPW_PKTRX_GetPreviousBufferStatus

```c
SPW_PKTRX_PREV_STATUS SPW_PKTRX_GetPreviousBufferStatus(void)
```

**Summary**

Get the previous buffer status of SPW packet RX module

**Preconditions**

None

**Parameters**

None

**Returns**

Current value of previous buffer status of SPW packet RX module

---

### SPW_PKTTX_StatusGet

```c
SPW_PKTTX_STATUS SPW_PKTTX_StatusGet(void)
```

**Summary**

Get the SPW packet TX module status

**Preconditions**

None

**Parameters**

None

**Returns**

Current status of SPW packet TX module

---

### SPW_PKTTX_IrqStatusGetMaskedAndClear

```c
SPW_PKTTX_INT_MASK SPW_PKTTX_IrqStatusGetMaskedAndClear(void);
```

**Summary**

Get the SPW packet TX module interrupt status for masked interrupt and clear them

**Preconditions**

None

**Parameters**

None

**Returns**

Current interrupt status of SPW packet TX module

---

### SPW_RMAP_StatusGetAndClear

```c
SPW_RMAP_STATUS SPW_RMAP_StatusGetAndClear(void)
```

**Summary**

Get SPW RMAP Status and clear

**Preconditions**

None

**Parameters**

None

**Returns**

SPW RMAP Status

---

### SPW_ROUTER_StatusGet

```c
SPW_ROUTER_STATUS SPW_ROUTER_StatusGet(void)
```

**Summary**

Get SPW ROUTER Status

**Preconditions**

None

**Parameters**

None

**Returns**

SPW ROUTER Status

---

### SPW_ROUTER_TimeoutStatusGet

```c
SPW_ROUTER_TIMEOUT_STATUS SPW_ROUTER_TimeoutStatusGet(void)
```

**Summary**

Get SPW ROUTER Timeout Status

**Preconditions**

None

**Parameters**

None

**Returns**

SPW ROUTER Timeout Status
