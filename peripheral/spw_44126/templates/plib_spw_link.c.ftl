/*******************************************************************************
  SPW Peripheral Library
  Source File

  Company:
    Microchip Technology Inc.

  File Name:
    plib_${SPW_INSTANCE_NAME?lower_case}_link.c

  Summary:
    ${SPW_INSTANCE_NAME} PLIB Implementation file

  Description:
    This file defines the interface to the ${SPW_INSTANCE_NAME} peripheral library.
    This library provides access to and control of the associated peripheral
    instance.

*******************************************************************************/
// DOM-IGNORE-BEGIN
/*******************************************************************************
* Copyright (C) 2019 Microchip Technology Inc. and its subsidiaries.
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

#include "device.h"
#include "plib_${SPW_INSTANCE_NAME?lower_case}_link.h"

// *****************************************************************************
// *****************************************************************************
// ${SPW_INSTANCE_NAME} PLib Interface Routines
// *****************************************************************************
// *****************************************************************************
// *****************************************************************************

/* Function:
    void ${SPW_INSTANCE_NAME}_LINK_Initialize(void)

   Summary:
    Initialize LINK modules of the ${SPW_INSTANCE_NAME} peripheral.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None
*/
void ${SPW_INSTANCE_NAME}_LINK_Initialize(void)
{
    <#list 1..2 as i>
    <#assign LINK_INIT_DIV = "SPW_LINK" + i + "_INIT_DIV" >
    <#assign LINK_OPER_DIV = "SPW_LINK" + i + "_OPER_DIV" >
    <#assign LINK_CMD = "SPW_LINK" + i + "_CMD" >
    /* Initialize link ${i} clock divisor */
    SPW_REGS->SPW_LINK${i}_CLKDIV = SPW_LINK${i}_CLKDIV_TXINITDIV(${.vars[LINK_INIT_DIV]}) | SPW_LINK${i}_CLKDIV_TXOPERDIV(${.vars[LINK_OPER_DIV]});

    /* Set link ${i} configuration command */
    SPW_REGS->SPW_LINK${i}_CFG = SPW_LINK${i}_CFG_COMMAND(${.vars[LINK_CMD]});
    </#list>
}

// *****************************************************************************
/* Function:
    SPW_LINK_STATUS ${SPW_INSTANCE_NAME}_LINK_StatusGet(SPW_LINK link)

   Summary:
    Get the SPW LINK status of the given ${SPW_INSTANCE_NAME} link.

   Precondition:
    None.

   Parameters:
    link - the selected link ID.

   Returns:
    Current status of the selected ${SPW_INSTANCE_NAME} link.
*/
SPW_LINK_STATUS ${SPW_INSTANCE_NAME}_LINK_StatusGet(SPW_LINK link)
{
    uint32_t status = 0;
    if ( link == SPW_LINK_1 )
    {
        status = SPW_REGS->SPW_LINK1_STATUS;
    }
    else if ( link == SPW_LINK_2 )
    {
        status = SPW_REGS->SPW_LINK2_STATUS;
    }
    else
    {
        /* Link index not supported */
    }
    return (SPW_LINK_STATUS)(status);
}

<#if INTERRUPT_MODE == true>
// *****************************************************************************
/* Function:
    SPW_LINK_INT_MASK ${SPW_INSTANCE_NAME}_LINK_IrqStatusGetMaskedAndClear(SPW_LINK link);

   Summary:
    Get the SPW LINK interrupt status for masked interrupts and clear them for the
    selected link interface.

   Precondition:
    None.

   Parameters:
    link - the selected link ID.

   Returns:
    Current interrupt status of the selected link.
*/
SPW_LINK_INT_MASK ${SPW_INSTANCE_NAME}_LINK_IrqStatusGetMaskedAndClear(SPW_LINK link)
{
    uint32_t pendingMaskedIrq = 0;
    if (link == SPW_LINK_1)
    {
        pendingMaskedIrq = SPW_REGS->SPW_LINK1_PI_RM;
        SPW_REGS->SPW_LINK1_PI_C = pendingMaskedIrq;
    }
    else if ( link == SPW_LINK_2 )
    {
        pendingMaskedIrq = SPW_REGS->SPW_LINK2_PI_RM;
        SPW_REGS->SPW_LINK2_PI_C = pendingMaskedIrq;
    }
    else
    {
        /* Link index not supported */
    }
    return (SPW_LINK_INT_MASK)(pendingMaskedIrq);
}

// *****************************************************************************
/* Function:
    void ${SPW_INSTANCE_NAME}_LINK_InterruptEnable(SPW_LINK link, SPW_LINK_INT_MASK interruptMask)

   Summary:
    Enables SPW LINK Interrupt for a given link interface.

   Precondition:
    ${SPW_INSTANCE_NAME}_Initialize must have been called for the associated SPW instance.

   Parameters:
    link - the selected link ID.
    interruptMask - Interrupt to be enabled

   Returns:
    None
*/
void ${SPW_INSTANCE_NAME}_LINK_InterruptEnable(SPW_LINK link, SPW_LINK_INT_MASK interruptMask)
{
    if ( link == SPW_LINK_1 )
    {
        SPW_REGS->SPW_LINK1_IM_S = (uint32_t)interruptMask;
    }
    else if ( link == SPW_LINK_2 )
    {
        SPW_REGS->SPW_LINK2_IM_S = (uint32_t)interruptMask;
    }
    else
    {
        /* Link index not supported */
    }
}

// *****************************************************************************
/* Function:
    void ${SPW_INSTANCE_NAME}_LINK_InterruptDisable(SPW_LINK link, SPW_LINK_INT_MASK interruptMask)

   Summary:
    Disables SPW LINK Interrupt for a given link interface.

   Precondition:
    ${SPW_INSTANCE_NAME}_Initialize must have been called for the associated SPW instance.

   Parameters:
    link - the selected link ID.
    interruptMask - Interrupt to be disabled

   Returns:
    None
*/
void ${SPW_INSTANCE_NAME}_LINK_InterruptDisable(SPW_LINK link, SPW_LINK_INT_MASK interruptMask)
{
    if ( link == SPW_LINK_1 )
    {
        SPW_REGS->SPW_LINK1_IM_C = (uint32_t)interruptMask;
    }
    else if ( link == SPW_LINK_2 )
    {
        SPW_REGS->SPW_LINK2_IM_C = (uint32_t)interruptMask;
    }
    else
    {
        /* Link index not supported */
    }
}

// *****************************************************************************
/* Function:
    SPW_LINK_DIST_INT_MASK ${SPW_INSTANCE_NAME}_LINK_DistIrqStatusGetMaskedAndClear(SPW_LINK link)

   Summary:
    Get the SPW LINK Distributed interrupts status for masked interrupts and clear them for the
    selected link interface.

   Precondition:
    None.

   Parameters:
    link - the selected link ID.

   Returns:
    Current distributed interrupts status of the selected link.
*/
SPW_LINK_DIST_INT_MASK ${SPW_INSTANCE_NAME}_LINK_DistIrqStatusGetMaskedAndClear(SPW_LINK link)
{
    uint32_t pendingMaskedIrq = 0;
    if (link == SPW_LINK_1)
    {
        pendingMaskedIrq = SPW_REGS->SPW_LINK1_DISTINTPI_RM;
        SPW_REGS->SPW_LINK1_DISTINTPI_C = pendingMaskedIrq;
    }
    else if ( link == SPW_LINK_2 )
    {
        pendingMaskedIrq = SPW_REGS->SPW_LINK2_DISTINTPI_RM;
        SPW_REGS->SPW_LINK2_DISTINTPI_C = pendingMaskedIrq;
    }
    else
    {
        /* Link index not supported */
    }
    return (SPW_LINK_DIST_INT_MASK)(pendingMaskedIrq);
}

// *****************************************************************************
/* Function:
    void ${SPW_INSTANCE_NAME}_LINK_DistInterruptEnable(SPW_LINK link, SPW_LINK_DIST_INT_MASK interruptMask)

   Summary:
    Enables SPW LINK Distributed Interrupts for a given link interface.

   Precondition:
    ${SPW_INSTANCE_NAME}_Initialize must have been called for the associated SPW instance.

   Parameters:
    link - the selected link ID.
    interruptMask - Distributed Interrupts to be enabled

   Returns:
    None
*/
void ${SPW_INSTANCE_NAME}_LINK_DistInterruptEnable(SPW_LINK link, SPW_LINK_DIST_INT_MASK interruptMask)
{
    if ( link == SPW_LINK_1 )
    {
        SPW_REGS->SPW_LINK1_DISTINTIM_S = (uint32_t)interruptMask;
    }
    else if ( link == SPW_LINK_2 )
    {
        SPW_REGS->SPW_LINK2_DISTINTIM_S = (uint32_t)interruptMask;
    }
    else
    {
        /* Link index not supported */
    }
}

// *****************************************************************************
/* Function:
    void ${SPW_INSTANCE_NAME}_LINK_DistInterruptDisable(SPW_LINK link, SPW_LINK_DIST_INT_MASK interruptMask)

   Summary:
    Disables SPW LINK Distributed Interrupts for a given link interface.

   Precondition:
    ${SPW_INSTANCE_NAME}_Initialize must have been called for the associated SPW instance.

   Parameters:
    link - the selected link ID.
    interruptMask - Distributed Interrupts to be disabled

   Returns:
    None
*/
void ${SPW_INSTANCE_NAME}_LINK_DistInterruptDisable(SPW_LINK link, SPW_LINK_DIST_INT_MASK interruptMask)
{
    if ( link == SPW_LINK_1 )
    {
        SPW_REGS->SPW_LINK1_DISTINTIM_C = (uint32_t)interruptMask;
    }
    else if ( link == SPW_LINK_2 )
    {
        SPW_REGS->SPW_LINK2_DISTINTIM_C = (uint32_t)interruptMask;
    }
    else
    {
        /* Link index not supported */
    }
}

// *****************************************************************************
/* Function:
    SPW_LINK_DIST_ACK_MASK ${SPW_INSTANCE_NAME}_LINK_DistAckIrqStatusGetMaskedAndClear(SPW_LINK link)

   Summary:
    Get the SPW LINK Distributed acknowledge interrupts status for masked interrupts and clear them for the
    selected link interface.

   Precondition:
    None.

   Parameters:
    link - the selected link ID.

   Returns:
    Current distributed acknowledge interrupts status of the selected link.
*/
SPW_LINK_DIST_ACK_MASK ${SPW_INSTANCE_NAME}_LINK_DistAckIrqStatusGetMaskedAndClear(SPW_LINK link)
{
    uint32_t pendingMaskedIrq = 0;
    if (link == SPW_LINK_1)
    {
        pendingMaskedIrq = SPW_REGS->SPW_LINK1_DISTACKPI_RM;
        SPW_REGS->SPW_LINK1_DISTACKPI_C = pendingMaskedIrq;
    }
    else if ( link == SPW_LINK_2 )
    {
        pendingMaskedIrq = SPW_REGS->SPW_LINK2_DISTACKPI_RM;
        SPW_REGS->SPW_LINK2_DISTACKPI_C = pendingMaskedIrq;
    }
    else
    {
        /* Link index not supported */
    }
    return (SPW_LINK_DIST_ACK_MASK)(pendingMaskedIrq);
}

// *****************************************************************************
/* Function:
    void ${SPW_INSTANCE_NAME}_LINK_DistAckInterruptEnable(SPW_LINK link, SPW_LINK_DIST_INT_MASK interruptMask)

   Summary:
    Enables SPW LINK Distributed Acknowledge Interrupts for a given link interface.

   Precondition:
    ${SPW_INSTANCE_NAME}_Initialize must have been called for the associated SPW instance.

   Parameters:
    link - the selected link ID.
    interruptMask - Distributed Acknowledge Interrupts to be enabled

   Returns:
    None
*/
void ${SPW_INSTANCE_NAME}_LINK_DistAckInterruptEnable(SPW_LINK link, SPW_LINK_DIST_ACK_MASK interruptMask)
{
    if ( link == SPW_LINK_1 )
    {
        SPW_REGS->SPW_LINK1_DISTACKIM_S = (uint32_t)interruptMask;
    }
    else if ( link == SPW_LINK_2 )
    {
        SPW_REGS->SPW_LINK2_DISTACKIM_S = (uint32_t)interruptMask;
    }
    else
    {
        /* Link index not supported */
    }
}

// *****************************************************************************
/* Function:
    void ${SPW_INSTANCE_NAME}_LINK_DistAckInterruptDisable(SPW_LINK link, SPW_LINK_DIST_INT_MASK interruptMask)

   Summary:
    Disables SPW LINK Distributed Acknowledge Interrupts for a given link interface.

   Precondition:
    ${SPW_INSTANCE_NAME}_Initialize must have been called for the associated SPW instance.

   Parameters:
    link - the selected link ID.
    interruptMask - Distributed Acknowledge Interrupts to be disabled

   Returns:
    None
*/
void ${SPW_INSTANCE_NAME}_LINK_DistAckInterruptDisable(SPW_LINK link, SPW_LINK_DIST_ACK_MASK interruptMask)
{
    if ( link == SPW_LINK_1 )
    {
        SPW_REGS->SPW_LINK1_DISTACKIM_C = (uint32_t)interruptMask;
    }
    else if ( link == SPW_LINK_2 )
    {
        SPW_REGS->SPW_LINK2_DISTACKIM_C = (uint32_t)interruptMask;
    }
    else
    {
        /* Link index not supported */
    }
}

// *****************************************************************************
/* Function:
    void ${SPW_INSTANCE_NAME}_LINK_EscapeCharEvent1Set(SPW_LINK link, bool active, uint8_t mask, uint8_t value)

   Summary:
    Set SPW LINK Escape Character match event 1 for a given link interface.

   Precondition:
    ${SPW_INSTANCE_NAME}_Initialize must have been called for the associated SPW instance.

   Parameters:
    link - the selected link ID.
    active - True is the match event 1 is active, False otherwise.
    mask - Bits mask of incoming escape character to check.
    value - Value to check in incoming escape character.

   Returns:
    None
*/
void ${SPW_INSTANCE_NAME}_LINK_EscapeCharEvent1Set(SPW_LINK link, bool active, uint8_t mask, uint8_t value)
{
    if ( link == SPW_LINK_1 )
    {
        if (active == true)
        {
<#if SPW_IS_LINK_EVT_REG_TABLE == false>
            SPW_REGS->SPW_LINK1_ESCCHAREVENT0 = SPW_LINK1_ESCCHAREVENT0_ACTIVE(1) | SPW_LINK1_ESCCHAREVENT0_MASK(mask) | SPW_LINK1_ESCCHAREVENT0_VALUE(value);
<#else>
            SPW_REGS->SPW_LINK1_ESCCHAREVENT[0] = SPW_LINK1_ESCCHAREVENT_ACTIVE(1) | SPW_LINK1_ESCCHAREVENT_MASK(mask) | SPW_LINK1_ESCCHAREVENT_VALUE(value);
</#if>
        }
        else
        {
<#if SPW_IS_LINK_EVT_REG_TABLE == false>
            SPW_REGS->SPW_LINK1_ESCCHAREVENT0 = 0;
<#else>
            SPW_REGS->SPW_LINK1_ESCCHAREVENT[0] = 0;
</#if>
        }
    }
    else if ( link == SPW_LINK_2 )
    {
        if (active == true)
        {
<#if SPW_IS_LINK_EVT_REG_TABLE == false>
            SPW_REGS->SPW_LINK2_ESCCHAREVENT0 = SPW_LINK2_ESCCHAREVENT0_ACTIVE(1) | SPW_LINK2_ESCCHAREVENT0_MASK(mask) | SPW_LINK2_ESCCHAREVENT0_VALUE(value);
<#else>
            SPW_REGS->SPW_LINK2_ESCCHAREVENT[0] = SPW_LINK2_ESCCHAREVENT_ACTIVE(1) | SPW_LINK2_ESCCHAREVENT_MASK(mask) | SPW_LINK2_ESCCHAREVENT_VALUE(value);
</#if>
        }
        else
        {
<#if SPW_IS_LINK_EVT_REG_TABLE == false>
            SPW_REGS->SPW_LINK2_ESCCHAREVENT0 = 0;
<#else>
            SPW_REGS->SPW_LINK2_ESCCHAREVENT[0] = 0;
</#if>
        }
    }
    else
    {
        /* Link index not supported */
    }
}

// *****************************************************************************
/* Function:
    void ${SPW_INSTANCE_NAME}_LINK_EscapeCharEvent2Set(SPW_LINK link, bool active, uint8_t mask, uint8_t value)

   Summary:
    Set SPW LINK Escape Character match event 2 for a given link interface.

   Precondition:
    ${SPW_INSTANCE_NAME}_Initialize must have been called for the associated SPW instance.

   Parameters:
    link - the selected link ID.
    active - True is the match event 2 is active, False otherwise.
    mask - Bits mask of incoming escape character to check.
    value - Value to check in incoming escape character.

   Returns:
    None
*/
void ${SPW_INSTANCE_NAME}_LINK_EscapeCharEvent2Set(SPW_LINK link, bool active, uint8_t mask, uint8_t value)
{
    if ( link == SPW_LINK_1 )
    {
        if (active == true)
        {
<#if SPW_IS_LINK_EVT_REG_TABLE == false>
            SPW_REGS->SPW_LINK1_ESCCHAREVENT1 = SPW_LINK1_ESCCHAREVENT1_ACTIVE(1) | SPW_LINK1_ESCCHAREVENT1_MASK(mask) | SPW_LINK1_ESCCHAREVENT1_VALUE(value);
<#else>
            SPW_REGS->SPW_LINK1_ESCCHAREVENT[1] = SPW_LINK1_ESCCHAREVENT_ACTIVE(1) | SPW_LINK1_ESCCHAREVENT_MASK(mask) | SPW_LINK1_ESCCHAREVENT_VALUE(value);
</#if>
        }
        else
        {
<#if SPW_IS_LINK_EVT_REG_TABLE == false>
            SPW_REGS->SPW_LINK1_ESCCHAREVENT1 = 0;
<#else>
            SPW_REGS->SPW_LINK1_ESCCHAREVENT[1] = 0;
</#if>
        }
    }
    else if ( link == SPW_LINK_2 )
    {
        if (active == true)
        {
<#if SPW_IS_LINK_EVT_REG_TABLE == false>
            SPW_REGS->SPW_LINK2_ESCCHAREVENT1 = SPW_LINK2_ESCCHAREVENT1_ACTIVE(1) | SPW_LINK2_ESCCHAREVENT1_MASK(mask) | SPW_LINK2_ESCCHAREVENT1_VALUE(value);
<#else>
            SPW_REGS->SPW_LINK2_ESCCHAREVENT[1] = SPW_LINK2_ESCCHAREVENT_ACTIVE(1) | SPW_LINK2_ESCCHAREVENT_MASK(mask) | SPW_LINK2_ESCCHAREVENT_VALUE(value);
</#if>
        }
        else
        {
<#if SPW_IS_LINK_EVT_REG_TABLE == false>
            SPW_REGS->SPW_LINK2_ESCCHAREVENT1 = 0;
<#else>
            SPW_REGS->SPW_LINK2_ESCCHAREVENT[1] = 0;
</#if>
        }
    }
    else
    {
        /* Link index not supported */
    }
}

/* MISRA C-2012 Rule 5.1 is deviated in the below code block. Deviation record ID - H3_MISRAC_2012_R_5_1_DR_1*/
<#if core.COVERITY_SUPPRESS_DEVIATION?? && core.COVERITY_SUPPRESS_DEVIATION>
<#if core.COMPILER_CHOICE == "XC32">
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunknown-pragmas"
</#if>
#pragma coverity compliance block deviate "MISRA C-2012 Rule 5.1"  "H3_MISRAC_2012_R_5_1_DR_1"
</#if>

// *****************************************************************************
/* Function:
    void ${SPW_INSTANCE_NAME}_LINK_LastRecvEscapeCharEventGet(SPW_LINK link)

   Summary:
    Get SPW LINK latest received Escape Character matching event 1 for a given link interface.

   Precondition:
    ${SPW_INSTANCE_NAME}_Initialize must have been called for the associated SPW instance.

   Parameters:
    link - the selected link ID.

   Returns:
    Latest received escape character matching event 1.
*/
uint8_t ${SPW_INSTANCE_NAME}_LINK_LastRecvEscapeCharEvent1Get(SPW_LINK link)
{
    uint8_t charEvent1 = 0;
    if ( link == SPW_LINK_1 )
    {
        charEvent1 = (uint8_t)( (SPW_REGS->SPW_LINK1_ESCCHARSTS & SPW_LINK1_ESCCHARSTS_CHAR1_Msk) >> SPW_LINK1_ESCCHARSTS_CHAR1_Pos );
    }
    else if ( link == SPW_LINK_2 )
    {
        charEvent1 = (uint8_t)( (SPW_REGS->SPW_LINK2_ESCCHARSTS & SPW_LINK2_ESCCHARSTS_CHAR1_Msk) >> SPW_LINK2_ESCCHARSTS_CHAR1_Pos );
    }
    else
    {
        /* Link index not supported */
    }
    return charEvent1;
}

// *****************************************************************************
/* Function:
    uint8_t ${SPW_INSTANCE_NAME}_LINK_LastRecvEscapeCharEvent2Get(SPW_LINK link)

   Summary:
    Get SPW LINK latest received Escape Character matching event 2 for a given link interface.

   Precondition:
    ${SPW_INSTANCE_NAME}_Initialize must have been called for the associated SPW instance.

   Parameters:
    link - the selected link ID.

   Returns:
    Latest received escape character matching event 2
*/
uint8_t ${SPW_INSTANCE_NAME}_LINK_LastRecvEscapeCharEvent2Get(SPW_LINK link)
{
    uint8_t charEvent2 = 0;
    if ( link == SPW_LINK_1 )
    {
        charEvent2 = (uint8_t)( (SPW_REGS->SPW_LINK1_ESCCHARSTS & SPW_LINK1_ESCCHARSTS_CHAR2_Msk) >> SPW_LINK1_ESCCHARSTS_CHAR2_Pos );
    }
    else if ( link == SPW_LINK_2 )
    {
        charEvent2 = (uint8_t)( (SPW_REGS->SPW_LINK2_ESCCHARSTS & SPW_LINK2_ESCCHARSTS_CHAR2_Msk) >> SPW_LINK2_ESCCHARSTS_CHAR2_Pos );
    }
    else
    {
        /* Link index not supported */
    }
    return charEvent2;
}

<#if core.COVERITY_SUPPRESS_DEVIATION?? && core.COVERITY_SUPPRESS_DEVIATION>
#pragma coverity compliance end_block "MISRA C-2012 Rule 5.1"
<#if core.COMPILER_CHOICE == "XC32">
#pragma GCC diagnostic pop
</#if>
</#if>
/* MISRAC 2012 deviation block end */

// *****************************************************************************
/* Function:
    void ${SPW_INSTANCE_NAME}_LINK_TransmitEscapeChar(SPW_LINK link, uint8_t char)

   Summary:
    Transmit escape character on the given SPW LINK interface.

   Precondition:
    ${SPW_INSTANCE_NAME}_Initialize must have been called for the associated SPW instance.

   Parameters:
    link - the selected link ID.
    char - Escape Character to transmit.

   Returns:
    None
*/
void ${SPW_INSTANCE_NAME}_LINK_TransmitEscapeChar(SPW_LINK link, uint8_t escChar)
{
    if ( link == SPW_LINK_1 )
    {
        SPW_REGS->SPW_LINK1_TRANSESC = SPW_LINK1_TRANSESC_CHAR(escChar);
    }
    else if ( link == SPW_LINK_2 )
    {
        SPW_REGS->SPW_LINK2_TRANSESC = SPW_LINK2_TRANSESC_CHAR(escChar);
    }
    else
    {
        /* Link index not supported */
    }
}

</#if>
