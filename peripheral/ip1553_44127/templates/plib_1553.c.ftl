/*******************************************************************************
  MIL-1553 Library
  Source File

  Company:
    Microchip Technology Inc.

  File Name:
    plib_${IP1553_INSTANCE_NAME?lower_case}.c

  Summary:
    ${IP1553_INSTANCE_NAME} PLIB Implementation file

  Description:
    This file defines the interface to the ${IP1553_INSTANCE_NAME} peripheral library.
    This library provides access to and control of the associated peripheral
    instance.

*******************************************************************************/
// DOM-IGNORE-BEGIN
/*******************************************************************************
* Copyright (C) 2018-2019 Microchip Technology Inc. and its subsidiaries.
*
* Subject to your compliance with these terms, you may use Microchip software
* and any derivatives exclusively with Microchip products. It is your
* responsibility to comply with third party license terms applicable to your
* use of third party software (including open source software) that may
* accompany Microchip software.
*
* THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS". NO WARRANTIES, WHETHER
* EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, INCLUDING ANY IMPLIED
* WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A
* PARTICULAR PURPOSE.
*
* IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE,
* INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY KIND
* WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF MICROCHIP HAS
* BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE. TO THE
* FULLEST EXTENT ALLOWED BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN
* ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT OF FEES, IF ANY,
* THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS SOFTWARE.
*******************************************************************************/
// DOM-IGNORE-END

// *****************************************************************************
// *****************************************************************************
// Section: Included Files
// *****************************************************************************
// *****************************************************************************

#include <stddef.h>
#include "device.h"
<#if core.CoreSysIntFile == true>
#include "interrupts.h"
</#if>
#include "plib_${IP1553_INSTANCE_NAME?lower_case}.h"

// *****************************************************************************
// *****************************************************************************
// Section: Global Data
// *****************************************************************************
// *****************************************************************************

<#if INTERRUPT_MODE == true>
static IP1553_OBJ ${IP1553_INSTANCE_NAME?lower_case}Obj;
</#if>

// *****************************************************************************
// *****************************************************************************
// ${IP1553_INSTANCE_NAME} PLib Interface Routines
// *****************************************************************************
// *****************************************************************************
// *****************************************************************************

/* Function:
    void ${IP1553_INSTANCE_NAME}_Initialize(void)

   Summary:
    Initializes given instance of the ${IP1553_INSTANCE_NAME} peripheral.
    Set the Mode (Bus Controller or Remote Terminal) and reset the instance.
    In RT mode, set the RT Address.
    Enable all 1553 interrupt sources.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None
*/
void ${IP1553_INSTANCE_NAME}_Initialize(void)
{
<#if IP1553_MODE == "RT">
    // Select RT mode and reset instance
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_CR = IP1553_CR_PT(0) | IP1553_CR_TA(${IP1553_RT_ADDR}) | IP1553_CR_RST(1);
<#else>
    // Select BC mode and reset instance
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_CR = IP1553_CR_PT(1) | IP1553_CR_RST(1);
</#if>
}

// *****************************************************************************
/* Function:
    void ${IP1553_INSTANCE_NAME}_BuffersConfigSet(uint16_t* txBuffers, uint16_t* rxBuffers)

   Summary:
    Set the memory base address for emmission and reception buffers.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.

   Parameters:
    txBuffers - Pointer to application allocated emission buffer base address.
                Application must allocate buffer from non-cached
                contiguous memory and buffer size must be
                16 bit * IP1553_BUFFERS_SIZE * IP1553_BUFFERS_NUM
    rxBuffers - Pointer to application allocated reception buffer base address.
                Application must allocate buffer from non-cached
                contiguous memory and buffer size must be
                16 bit * IP1553_BUFFERS_SIZE * IP1553_BUFFERS_NUM

   Returns:
    None.
*/
void ${IP1553_INSTANCE_NAME}_BuffersConfigSet(uint16_t* txBuffers, uint16_t* rxBuffers)
{
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_ARW = IP1553_ARW_REG_ADDR_APB_W((uint32_t) txBuffers);
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_ARR = IP1553_ARR_REG_ADDR_APB_R((uint32_t) rxBuffers);
}

// *****************************************************************************
/* Function:
    uint32_t ${IP1553_INSTANCE_NAME}_GetTxBuffersStatus(void)

   Summary:
    Returns the transmission buffers status.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.

   Parameters:
    None.

   Returns:
    Bitfield value that indicates for each of the 32 buffers if they are
    ready to be sent (1) or are empty (0).
*/
uint32_t ${IP1553_INSTANCE_NAME}_GetTxBuffersStatus(void)
{
    return ${IP1553_INSTANCE_NAME}_REGS->IP1553_TXBSR;
}

// *****************************************************************************
/* Function:
    void ${IP1553_INSTANCE_NAME}_ResetTxBuffersStatus(uint32_t buffers)

   Summary:
    Reset the transmission buffers status.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.

   Parameters:
    buffers  - Bitfield of buffer to be reset.
               When reset a buffer is set ready to be sent (1) in status.

   Returns:
    None.
*/
void ${IP1553_INSTANCE_NAME}_ResetTxBuffersStatus(uint32_t buffers)
{
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_TXBSR = buffers;
}

// *****************************************************************************
/* Function:
    uint32_t ${IP1553_INSTANCE_NAME}_GetRxBuffersStatus(void)

   Summary:
    Returns the reception buffers status.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.

   Parameters:
    None.

   Returns:
    Bitfield value that indicates for each of the 32 buffers if they are
    free to receive data or not : empty (1) or full(0).
*/
uint32_t ${IP1553_INSTANCE_NAME}_GetRxBuffersStatus(void)
{
    return ${IP1553_INSTANCE_NAME}_REGS->IP1553_RXBSR;
}

// *****************************************************************************
/* Function:
    void ${IP1553_INSTANCE_NAME}_ResetRxBuffersStatus(uint32_t buffers)

   Summary:
    Reset the reception buffers status.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.

   Parameters:
    buffers  - Bitfield of buffer to be reset.
               When reset a buffer is set ready to receive data (1) in status.

   Returns:
    None.
*/
void ${IP1553_INSTANCE_NAME}_ResetRxBuffersStatus(uint32_t buffers)
{
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_RXBSR = buffers;
}

// *****************************************************************************
/* Function:
    IP1553_INT_MASK ${IP1553_INSTANCE_NAME}_IrqStatusGet( void )

   Summary:
    Returns the ${IP1553_INSTANCE_NAME} status.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.

   Parameters:
    None.

   Returns:
    Current status of instance.
*/
IP1553_INT_MASK ${IP1553_INSTANCE_NAME}_IrqStatusGet( void )
{
    return (IP1553_INT_MASK)(${IP1553_INSTANCE_NAME}_REGS->IP1553_ISR);
}

<#if IP1553_MODE == "BC">
// *****************************************************************************
/* Function:
    void ${IP1553_INSTANCE_NAME}_BcStartDataTransfer(IP1553_DATA_TX_TYPE transferType, uint8_t txAddr, uint8_t txSubAddr, uint8_t rxAddr, uint8_t rxSubAddr, uint8_t dataWordCount, IP1553_BUS bus )

   Summary:
    Start BC command for data transfer.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.
    ${IP1553_INSTANCE_NAME}_BuffersConfigSet must have been called to set allocated buffers.
    ${IP1553_INSTANCE_NAME}_ResetRxBuffersStatus and ${IP1553_INSTANCE_NAME}_ResetTxBuffersStatus must 
    have been called for the concerned buffers (sub-address) used in the command.

   Parameters:
    transferType   - Type of data tranfer command to issue.
    txAddr         - The transmitter address : 0 if BC, RT address otherwise.
    txSubAddr      - The transmitter sub-address.
    rxAddr         - The receiver address : 0 if BC, RT address otherwise.
    rxSubAddr      - The receiver sub-address.
    dataWordCount  - Number of data word (16 bit) to read/write. 0 stand for 32 data word.
    bus            - Indicate if the transfer uses physical BUS A or B. 

   Returns:
    None.
*/
void ${IP1553_INSTANCE_NAME}_BcStartDataTransfer(IP1553_DATA_TX_TYPE transferType, uint8_t txAddr, uint8_t txSubAddr, uint8_t rxAddr, uint8_t rxSubAddr, uint8_t dataWordCount, IP1553_BUS bus )
{
    // Receiver terminal
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_CMDR1 = \
            IP1553_CMDR1_RTADDRESS(rxAddr) | \
            IP1553_CMDR1_RTSUBADDRESS(rxSubAddr) | \
            IP1553_CMDR1_DATAWORDCOUNT(dataWordCount) ;

    // Transmitter terminal
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_CMDR2 = \
            IP1553_CMDR2_RTADDRESS(txAddr) | \
            IP1553_CMDR2_T_R(1) | \
            IP1553_CMDR2_RTSUBADDRESS(txSubAddr) | \
            IP1553_CMDR2_DATAWORDCOUNT(dataWordCount) ;

    uint32_t cmdr3 = IP1553_CMDR3_BUS(bus);
    if (transferType == IP1553_DATA_TX_TYPE_BC_TO_RT)
    {
        cmdr3 |= IP1553_CMDR3_BCE(1);
    }
    else if (transferType == IP1553_DATA_TX_TYPE_RT_TO_BC)
    {
        cmdr3 |= IP1553_CMDR3_BCR(1);
    }
    else
    {
        /* No data sent or received by BC */
    }
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_CMDR3 = cmdr3;
}

// *****************************************************************************
/* Function:
    void ${IP1553_INSTANCE_NAME}_BcModeCommandTransfer(uint8_t rtAddr, IP1553_MODE_CMD modeCommand, uint16_t cmdParameter, IP1553_BUS bus)

   Summary:
    Start BC mode command transfer.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.
    ${IP1553_INSTANCE_NAME}_BuffersConfigSet must have been called to set allocated buffers.

   Parameters:
    rtAddr         - The remote terminal address or 0x1F for broadcast.
    modeCommand    - The mode command code.
    cmdParameter   - Optional command parameter for applicable commande code.
    bus            - Indicate if the transfer uses physical BUS A or B. 

   Returns:
    None.
*/
void ${IP1553_INSTANCE_NAME}_BcModeCommandTransfer(uint8_t rtAddr, IP1553_MODE_CMD modeCommand, uint16_t cmdParameter, IP1553_BUS bus)
{
    uint8_t cmdr1Tr = 1;
    uint32_t cmdr2 = 0;

    /* Check if mode command contains data parameter */
    if ( modeCommand == IP1553_MODE_CMD_SYNCHRONIZE_WITH_DATA )
    {
        cmdr1Tr = 0;
        cmdr2 = cmdParameter;
    }

    // Mode command
    IP1553_REGS->IP1553_CMDR1 = \
            IP1553_CMDR1_RTADDRESS(rtAddr) | \
            IP1553_CMDR1_RTSUBADDRESS(0) | \
            IP1553_CMDR1_T_R(cmdr1Tr) | \
            IP1553_CMDR1_DATAWORDCOUNT(modeCommand) ;

    // Parameter for applicable commands
    IP1553_REGS->IP1553_CMDR2 = cmdr2;

    IP1553_REGS->IP1553_CMDR3 = IP1553_CMDR3_BUS(bus) | IP1553_CMDR3_ER(1);
}
</#if>
// *****************************************************************************
/* Function:
    uint16_t ${IP1553_INSTANCE_NAME}_GetFirstStatusWord( void )

   Summary:
    Returns the ${IP1553_INSTANCE_NAME} transfer first status word.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.

   Parameters:
    None.

   Returns:
    Value of transfer first status word.
*/
uint16_t ${IP1553_INSTANCE_NAME}_GetFirstStatusWord( void )
{
    return (uint16_t)( ( ${IP1553_INSTANCE_NAME}_REGS->IP1553_CTRL1 & IP1553_CTRL1_IP1553DATA1_Msk ) >> IP1553_CTRL1_IP1553DATA1_Pos );
}

<#if IP1553_MODE == "BC">
// *****************************************************************************
/* Function:
    uint16_t ${IP1553_INSTANCE_NAME}_GetSecondStatusWord( void )

   Summary:
    Returns the ${IP1553_INSTANCE_NAME} transfer second status word.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.

   Parameters:
    None.

   Returns:
    Value of transfer second status word.
*/
uint16_t ${IP1553_INSTANCE_NAME}_GetSecondStatusWord( void )
{
    return (uint16_t)( ( ${IP1553_INSTANCE_NAME}_REGS->IP1553_CTRL1 & IP1553_CTRL1_IP1553DATA2_Msk) >> IP1553_CTRL1_IP1553DATA2_Pos );
}
</#if>
<#if IP1553_MODE == "RT">
// *****************************************************************************
/* Function:
    void ${IP1553_INSTANCE_NAME}_BCEnableCmdSet(bool enable)

   Summary:
    Enable BCEnableCmd bit to accepts or rejects the control when the terminal
    receives a valid Dynamic Bus Control mode command. This is the value indicated
    in the Dynamic Bus Control bit of the status word sent in response to the mode command.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.

   Parameters:
    enable - If true, The terminal accepts the bus control. If false, the terminal reject the bus control.

   Returns:
    None
*/
void ${IP1553_INSTANCE_NAME}_BCEnableCmdSet(bool enable)
{
    uint32_t crReg = ( ${IP1553_INSTANCE_NAME}_REGS->IP1553_CR & ~IP1553_CR_BEC_Msk );
    if (enable == true)
    {
        crReg |= IP1553_CR_BEC(1);
    }
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_CR = crReg;
    while (IP1553_REGS->IP1553_CR != crReg)
    {
        /* Wait for the update of the configuration register with the new value */
    }
}

// *****************************************************************************
/* Function:
    void ${IP1553_INSTANCE_NAME}_SREQBitCmdSet(bool enable)

   Summary:
    Enable or Disable SREQBitCmd bit. Indicates the value of the Service Request
    bit to be returned in status word transfers.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.

   Parameters:
    enable - If true, Service Request bit returned in status word transfers is 1. 0 if false.

   Returns:
    None
*/
void ${IP1553_INSTANCE_NAME}_SREQBitCmdSet(bool enable)
{
    uint32_t crReg = ( ${IP1553_INSTANCE_NAME}_REGS->IP1553_CR & ~IP1553_CR_SRC_Msk );
    if (enable == true)
    {
        crReg |= IP1553_CR_SRC(1);
    }
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_CR = crReg;
    while (IP1553_REGS->IP1553_CR != crReg)
    {
        /* Wait for the update of the configuration register with the new value */
    }
}

// *****************************************************************************
/* Function:
    void ${IP1553_INSTANCE_NAME}_BusyBitCmdSet(bool enable)

   Summary:
    Enable or Disable SREQBitCmd bit. Indicates the value of the busy bit to be
    returned in status word transfers. If enabled, Inhibits the transmission of
    the data words in response to a transmit command and its corresponding interrupt.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.

   Parameters:
    enable - If true, busy bit returned in status word transfers is 1. 0 if false.

   Returns:
    None
*/
void ${IP1553_INSTANCE_NAME}_BusyBitCmdSet(bool enable)
{
    uint32_t crReg = ( ${IP1553_INSTANCE_NAME}_REGS->IP1553_CR & ~IP1553_CR_BC_Msk );
    if (enable == true)
    {
        crReg |= IP1553_CR_BC(1);
    }
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_CR = crReg;
    while (IP1553_REGS->IP1553_CR != crReg)
    {
        /* Wait for the update of the configuration register with the new value */
    }
}

// *****************************************************************************
/* Function:
    void ${IP1553_INSTANCE_NAME}_SSBitCmdSet(bool enable)

   Summary:
    Enable or Disable SSBitCmd bit. Indicates the value of the Subsystem Flag bit
    to be returned in status word transfers.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.

   Parameters:
    enable - If true, Subsystem Flag bit returned in status word transfers is 1. 0 if false.

   Returns:
    None
*/
void ${IP1553_INSTANCE_NAME}_SSBitCmdSet(bool enable)
{
    uint32_t crReg = ( ${IP1553_INSTANCE_NAME}_REGS->IP1553_CR & ~IP1553_CR_SC_Msk );
    if (enable == true)
    {
        crReg |= IP1553_CR_SC(1);
    }
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_CR = crReg;
    while (IP1553_REGS->IP1553_CR != crReg)
    {
        /* Wait for the update of the configuration register with the new value */
    }
}

// *****************************************************************************
/* Function:
    void ${IP1553_INSTANCE_NAME}_TRBitCmdSet(bool enable)

   Summary:
    Enable or Disable TRBitCmd bit. Indicates the value of the T/F bit to be
    returned in status word transfers.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.

   Parameters:
    enable - If true, T/F bit returned in status word transfers is 1. 0 if false.

   Returns:
    None

   Note:
    After reception of a valid Inhibit T/F Bit command the T/F bit is maintained
    at logic level 0.
*/
void ${IP1553_INSTANCE_NAME}_TRBitCmdSet(bool enable)
{
    uint32_t crReg = ( ${IP1553_INSTANCE_NAME}_REGS->IP1553_CR & ~IP1553_CR_TC_Msk );
    if (enable == true)
    {
        crReg |= IP1553_CR_TC(1);
    }
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_CR = crReg;
    while (IP1553_REGS->IP1553_CR != crReg)
    {
        /* Wait for the update of the configuration register with the new value */
    }
}

// *****************************************************************************
/* Function:
    void ${IP1553_INSTANCE_NAME}_BitWordSet(uint16_t bitWord)

   Summary:
    Set the built-in self test results in BIT register. This value is sent by
    the terminal in response to a "Transmit Built-In Test".

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.

   Parameters:
    bitWord - Built-in self test results value.

   Returns:
    None
*/
void ${IP1553_INSTANCE_NAME}_BitWordSet(uint16_t bitWord)
{
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_BITR = (uint32_t)( bitWord & 0xFFFFUL );
}

// *****************************************************************************
/* Function:
    void ${IP1553_INSTANCE_NAME}_VectorWordSet(uint16_t vectorWord)

   Summary:
    Set the Vector Word value to be sent by the terminal in response to
    a "Transmit Vector Word" command.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the ${IP1553_INSTANCE_NAME} instance.

   Parameters:
    vectorWord - Vector Word value to be sent by the terminal.

   Returns:
    None
*/
void ${IP1553_INSTANCE_NAME}_VectorWordSet(uint16_t vectorWord)
{
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_VWR = (uint32_t)( vectorWord & 0xFFFFUL );
}
</#if>

<#if INTERRUPT_MODE == true>
// *****************************************************************************
/* Function:
    void ${IP1553_INSTANCE_NAME}_CallbackRegister(IP1553_CALLBACK callback,
                                                              uintptr_t context)

   Summary:
    Sets the pointer to the function (and it's context) to be called when the
    given 1553's interrupt events occur.

  Description:
    This function sets the pointer to a client function to be called "back" when
    the given 1553's interrupt events occur. It also passes a context value
    (usually a pointer to a context structure) that is passed into the function
    when it is called. The specified callback function will be called from the
    peripheral interrupt context.

  Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the associated
    1553 instance.

  Parameters:
    callback      - A pointer to a function with a calling signature defined by
                    the IP1553_CALLBACK data type. Setting this to NULL
                    disables the callback feature.

    contextHandle - A value (usually a pointer) passed (unused) into the
                    function identified by the callback parameter.

  Returns:
    None.

  Remarks:
    None.
*/
void ${IP1553_INSTANCE_NAME}_CallbackRegister(IP1553_CALLBACK callback, uintptr_t contextHandle)
{
    if (callback == NULL)
    {
        return;
    }

    ${IP1553_INSTANCE_NAME?lower_case}Obj.callback = callback;
    ${IP1553_INSTANCE_NAME?lower_case}Obj.context = contextHandle;
}

// *****************************************************************************
/* Function:
    void ${IP1553_INSTANCE_NAME}_InterruptHandler(void)

   Summary:
    ${IP1553_INSTANCE_NAME} Peripheral Interrupt Handler.

   Description:
    This function is ${IP1553_INSTANCE_NAME} Peripheral Interrupt Handler and will
    called on every ${IP1553_INSTANCE_NAME} interrupt.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None.

   Remarks:
    The function is called as peripheral instance's interrupt handler if the
    instance interrupt is enabled. If peripheral instance's interrupt is not
    enabled user need to call it from the main while loop of the application.
*/
void __attribute__((used)) ${IP1553_INSTANCE_NAME}_InterruptHandler(void)
{

    if (${IP1553_INSTANCE_NAME?lower_case}Obj.callback != NULL)
    {
        ${IP1553_INSTANCE_NAME?lower_case}Obj.callback(${IP1553_INSTANCE_NAME?lower_case}Obj.context);
    }
}

// *****************************************************************************
/* Function:
    void ${IP1553_INSTANCE_NAME}_InterruptEnable(IP1553_INT_MASK interruptMask)

   Summary:
    Enables ${IP1553_INSTANCE_NAME} module Interrupt.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the associated IP1553 instance.

   Parameters:
    interruptMask - Interrupt to be enabled

   Returns:
    None
*/
void ${IP1553_INSTANCE_NAME}_InterruptEnable(IP1553_INT_MASK interruptMask)
{
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_IER = (uint32_t)interruptMask;
}

// *****************************************************************************
/* Function:
    void ${IP1553_INSTANCE_NAME}_InterruptDisable(IP1553_INT_MASK interruptMask)

   Summary:
    Disables ${IP1553_INSTANCE_NAME} module Interrupt.

   Precondition:
    ${IP1553_INSTANCE_NAME}_Initialize must have been called for the associated IP1553 instance.

   Parameters:
    interruptMask - Interrupt to be disabled

   Returns:
    None
*/
void ${IP1553_INSTANCE_NAME}_InterruptDisable(IP1553_INT_MASK interruptMask)
{
    ${IP1553_INSTANCE_NAME}_REGS->IP1553_IDR = (uint32_t)interruptMask;
}
</#if>
