/*******************************************************************************
  SPW Peripheral Library
  Source File

  Company:
    Microchip Technology Inc.

  File Name:
    plib_${SPW_INSTANCE_NAME?lower_case}_router.c

  Summary:
    ${SPW_INSTANCE_NAME} PLIB ROUTER Implementation file

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
#include "plib_${SPW_INSTANCE_NAME?lower_case}_router.h"

// *****************************************************************************
// *****************************************************************************
// ${SPW_INSTANCE_NAME} PLib Interface Routines
// *****************************************************************************
// *****************************************************************************
// *****************************************************************************

/* Function:
    void ${SPW_INSTANCE_NAME}_ROUTER_Initialize(void)

   Summary:
    Initialize ROUTER modules of the ${SPW_INSTANCE_NAME} peripheral.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None
*/
void ${SPW_INSTANCE_NAME}_ROUTER_Initialize(void)
{
    /* Set router configuration */
    ${SPW_INSTANCE_NAME}_ROUTER_TimeoutDisable(${.vars["${SPW_INSTANCE_NAME}_ROUTER_DISTIMEOUT"]?c});
    ${SPW_INSTANCE_NAME}_ROUTER_LogicalAddressRoutingEnable(${.vars["${SPW_INSTANCE_NAME}_ROUTER_LAENA"]?c});
    ${SPW_INSTANCE_NAME}_ROUTER_FallbackEnable(${.vars["${SPW_INSTANCE_NAME}_ROUTER_FALLBACK"]?c});

<#if .vars["${SPW_INSTANCE_NAME}_ROUTER_LAENA"] == true>
    /* Initialize all entried in logical address routing table to zero */
    for (uint8_t entry = 0; entry < 224; entry++)
    {
        SPW_REGS->SPW_ROUTER_TABLE[entry] = 0;
    }

    <#list 0..223 as i>
    <#assign ROUTER_DEL = "SPW_ROUTER_TABLE_LA" + (i+32) + "_DEL" >
    <#assign ROUTER_PHYS_ADDR = "SPW_ROUTER_TABLE_LA" + (i+32) + "_ADDR" >
    <#if .vars[ROUTER_PHYS_ADDR]?number != 0>
    /* Configure logical addresses ${i+32} in routing table */
    ${SPW_INSTANCE_NAME}_ROUTER_RoutingTableEntrySet(${i+32}, ${.vars[ROUTER_DEL]?c}, ${.vars[ROUTER_PHYS_ADDR]});
    </#if>
    </#list>
</#if>
}

// *****************************************************************************
/* Function:
    void ${SPW_INSTANCE_NAME}_ROUTER_TimeoutDisable(bool disable)

   Summary:
    Disable SPW ROUTER timeout event.

   Precondition:
    None.

   Parameters:
    disable - if true, Router timeout event is disabled. Enabled if false.

   Returns:
    None
*/
void ${SPW_INSTANCE_NAME}_ROUTER_TimeoutDisable(bool disable)
{
    SPW_REGS->SPW_ROUTER_CFG = ( SPW_REGS->SPW_ROUTER_CFG & ~SPW_ROUTER_CFG_DISTIMEOUT_Msk ) | SPW_ROUTER_CFG_DISTIMEOUT(disable == true);
}

// *****************************************************************************
/* Function:
    void ${SPW_INSTANCE_NAME}_ROUTER_LogicalAddressRoutingEnable(bool enable)

   Summary:
    Enable SPW ROUTER Logical Address Routing.

   Precondition:
    None.

   Parameters:
    enable - if true, Router Logical Address Routing is enable. Disabled if false.

   Returns:
    None
*/
void ${SPW_INSTANCE_NAME}_ROUTER_LogicalAddressRoutingEnable(bool enable)
{
    SPW_REGS->SPW_ROUTER_CFG = ( SPW_REGS->SPW_ROUTER_CFG & ~SPW_ROUTER_CFG_LAENA_Msk ) | SPW_ROUTER_CFG_LAENA(enable == true);
}

// *****************************************************************************
/* Function:
    void ${SPW_INSTANCE_NAME}_ROUTER_FallbackEnable(bool enable)

   Summary:
    Enable SPW ROUTER Fallback.

   Precondition:
    None.

   Parameters:
    enable - if true, Router Fallback is enable. Disabled if false.

   Returns:
    None
*/
void ${SPW_INSTANCE_NAME}_ROUTER_FallbackEnable(bool enable)
{
    SPW_REGS->SPW_ROUTER_CFG = ( SPW_REGS->SPW_ROUTER_CFG & ~SPW_ROUTER_CFG_FALLBACK_Msk ) | SPW_ROUTER_CFG_FALLBACK(enable == true);
}

// *****************************************************************************
/* Function:
    void ${SPW_INSTANCE_NAME}_ROUTER_RoutingTableEntrySet(uint8_t logicalAddress, bool delHeader, uint8_t physicalAddress)

   Summary:
    Set a SPW routing table entry for a logical address.

   Precondition:
    None.

   Parameters:
    logicalAddress - Logical address entry to configure between 32 to 255.
    delHeader - if true, discard router byte for this logical address.
    physicalAddress - The physical address were incoming packet will be routed.

   Returns:
    None
*/
void ${SPW_INSTANCE_NAME}_ROUTER_RoutingTableEntrySet(uint8_t logicalAddress, bool delHeader, SPW_ROUTER_PHYS_ADDR physicalAddress)
{
    if ( logicalAddress >= 32 )
    {
        SPW_REGS->SPW_ROUTER_TABLE[logicalAddress-32] = SPW_ROUTER_TABLE_DELHEAD(delHeader == true) | SPW_ROUTER_TABLE_ADDR(physicalAddress);
    }
}

// *****************************************************************************
/* Function:
    SPW_ROUTER_STATUS ${SPW_INSTANCE_NAME}_ROUTER_StatusGet(void)

   Summary:
    Get SPW ROUTER Status.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    SPW ROUTER Status
*/
SPW_ROUTER_STATUS ${SPW_INSTANCE_NAME}_ROUTER_StatusGet(void)
{
    return (SPW_ROUTER_STATUS)(SPW_REGS->SPW_ROUTER_STS);
}

// *****************************************************************************
/* Function:
    SPW_ROUTER_TIMEOUT_STATUS ${SPW_INSTANCE_NAME}_ROUTER_TimeoutStatusGet(void)

   Summary:
    Get SPW ROUTER Timeout Status.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    SPW ROUTER Timeout Status
*/
SPW_ROUTER_TIMEOUT_STATUS ${SPW_INSTANCE_NAME}_ROUTER_TimeoutStatusGet(void)
{
    return (SPW_ROUTER_TIMEOUT_STATUS)(SPW_REGS->SPW_ROUTER_TIMEOUT);
}
