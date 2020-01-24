/*******************************************************************************
  SPW Peripheral Library
  Instance Header File

  Company:
    Microchip Technology Inc.

  File Name:
    plib_${SPW_INSTANCE_NAME?lower_case}.h

  Summary:
    ${SPW_INSTANCE_NAME} PLIB Header file

  Description:
    This file defines the interface to the ${SPW_INSTANCE_NAME} peripheral 
    library. This library provides access to and control of the associated 
    peripheral instance.
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

#ifndef PLIB_${SPW_INSTANCE_NAME}_H
#define PLIB_${SPW_INSTANCE_NAME}_H

// *****************************************************************************
// *****************************************************************************
// Section: Included Files
// *****************************************************************************
// *****************************************************************************
/* This section lists the other files that are included in this file.
*/
#include "device.h"

// DOM-IGNORE-BEGIN
#ifdef __cplusplus // Provide C++ Compatibility
    extern "C" {
#endif
// DOM-IGNORE-END

// *****************************************************************************
// *****************************************************************************
// Section: ${SPW_INSTANCE_NAME} defines
// *****************************************************************************
// *****************************************************************************

// *****************************************************************************
// *****************************************************************************
// Section: ${SPW_INSTANCE_NAME} Types
// *****************************************************************************
// *****************************************************************************
/* SPW IRQ status
   Summary:
    Identifies the SPW IRQ lines that have pending interrupt

   Description:
    This data type identifies the SPW IRQ lines that have pending interrupt
*/
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
}SPW_INT_MASK;

<#if INTERRUPT_MODE == true>
// *****************************************************************************
/* SPW Callback

   Summary:
    SPW Callback Function Pointer.

   Description:
    This data type defines the SPW Callback Function Pointer.

   Remarks:
    None.
*/
typedef void (*SPW_CALLBACK) (SPW_INT_MASK irqStatus, uintptr_t contextHandle);

// *****************************************************************************

/* SPW PLib Instance Object

   Summary:
    SPW PLib Object structure.

   Description:
    This data structure defines the SPW PLib Instance Object.

   Remarks:
    None.
*/
typedef struct
{
    /* Transfer Event Callback for interrupt*/
    SPW_CALLBACK callback;

    /* Transfer Event Callback Context for interrupt*/
    uintptr_t context;
} SPW_OBJ;
</#if>

// *****************************************************************************
// *****************************************************************************
// Section: Interface Routines
// *****************************************************************************
// *****************************************************************************

/*
 * The following functions make up the methods (set of possible operations) of
 * this interface.
 */

void ${SPW_INSTANCE_NAME}_Initialize(void);

<#if INTERRUPT_MODE == true>
void SPW_CallbackRegister(SPW_CALLBACK callback, uintptr_t contextHandle);

void ${SPW_INSTANCE_NAME}_InterruptHandler(void);
</#if>

// DOM-IGNORE-BEGIN
#ifdef __cplusplus  // Provide C++ Compatibility
}
#endif
// DOM-IGNORE-END

#endif /* PLIB_${SPW_INSTANCE_NAME}_H */
