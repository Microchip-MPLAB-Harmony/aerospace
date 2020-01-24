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
    SPW_LINK_STATUS status = 0;
    if ( link == SPW_LINK_1 )
    {
        status = SPW_REGS->SPW_LINK1_STATUS;
    }
    else if ( link == SPW_LINK_2 )
    {
        status = SPW_REGS->SPW_LINK2_STATUS;
    }
    return status;
}

<#if INTERRUPT_MODE == true>
// *****************************************************************************
/* Function:
    SPW_LINK_INT_MASK ${SPW_INSTANCE_NAME}_LINK_IrqStatusGetMaskedAndClear(SPW_LINK link);

   Summary:
    Get the SPW LINK interrupt status for masked interrupt and clear them for the
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
    SPW_LINK_INT_MASK pendingMaskedIrq = 0;
    if (link == SPW_LINK_1)
    {
        pendingMaskedIrq = SPW_REGS->SPW_LINK1_PI_RM;
        SPW_REGS->SPW_LINK1_PI_C = pendingMaskedIrq;
    }
    else if (link == SPW_LINK_2)
    {
        pendingMaskedIrq = SPW_REGS->SPW_LINK2_PI_RM;
        SPW_REGS->SPW_LINK2_PI_C = pendingMaskedIrq;
    }
    return pendingMaskedIrq;
}

// *****************************************************************************
/* Function:
    void ${SPW_INSTANCE_NAME}_LINK_InterruptEnable(SPW_LINK link, SPW_LINK_INT_MASK interruptMask)

   Summary:
    Enables SPW LINK Interrupt for given link interface.

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
        SPW_REGS->SPW_LINK1_IM_S = interruptMask;
    }
    else if ( link == SPW_LINK_2 )
    {
        SPW_REGS->SPW_LINK2_IM_S = interruptMask;
    }
}

// *****************************************************************************
/* Function:
    void ${SPW_INSTANCE_NAME}_LINK_InterruptDisable(SPW_LINK link, SPW_LINK_INT_MASK interruptMask)

   Summary:
    Disables SPW LINK Interrupt for given link interface.

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
        SPW_REGS->SPW_LINK1_IM_C = interruptMask;
    }
    else if ( link == SPW_LINK_2 )
    {
        SPW_REGS->SPW_LINK2_IM_C = interruptMask;
    }
}
</#if>

