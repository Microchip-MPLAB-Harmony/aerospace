/*******************************************************************************
 Main Source File

 Company:
 Microchip Technology Inc.

 File Name:
 main.c

 Summary:
 This file contains the "main" function for a project.

 Description:
 This file contains the "main" function for a project.  The
 "main" function calls the "SYS_Initialize" function to initialize the state
 machines of all modules in the system
 *******************************************************************************/

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

// *****************************************************************************
// *****************************************************************************
// Section: Included Files
// *****************************************************************************
// *****************************************************************************
#include <stddef.h>                     // Defines NULL
#include <stdbool.h>                    // Defines true
#include <stdlib.h>                     // Defines EXIT_FAILURE
#include "definitions.h"                // SYS function prototypes
#include <string.h>                     // Defines strings for memset

// *****************************************************************************
// *****************************************************************************
// Section: Application defines
// *****************************************************************************
// *****************************************************************************
/* Define the bitfield mask of used 1553 buffers by the application */
#define APP_IP1553_BUFFER_USED              (IP1553_BUFFER_TO_BITFIELD_SA (0) |\
                                             IP1553_BUFFER_TO_BITFIELD_SA (1) |\
                                             IP1553_BUFFER_TO_BITFIELD_SA (2) |\
                                             IP1553_BUFFER_TO_BITFIELD_SA (3) |\
                                             IP1553_BUFFER_TO_BITFIELD_SA (31) )

// *****************************************************************************
// *****************************************************************************
// Section: Globals
// *****************************************************************************
// *****************************************************************************
/* Allocation of receive buffer for IP1553 */
uint16_t IP1553RxBuffersRAM[IP1553_BUFFERS_NUM][IP1553_BUFFERS_SIZE] __attribute__((aligned (32)))__attribute__((space(data), section (".ram_nocache")));

/* Allocation of transmit buffer for IP1553 */
uint16_t IP1553TxBuffersRAM[IP1553_BUFFERS_NUM][IP1553_BUFFERS_SIZE] __attribute__((aligned (32)))__attribute__((space(data), section (".ram_nocache")));

// *****************************************************************************
// *****************************************************************************
// Section: Local functions
// *****************************************************************************
// *****************************************************************************
/* void APP_IP1553_Print_Errors(uint32_t errors)

 Summary:
 Function called by application to print the description of the errors that
 occurred during transfer.

 Description:
 Print the description of the errors that are set in the given bit field.

 Parameters:
 errors - Bit field of the IP1553 status that contains errors.

 Remarks:
 None.
 */
void APP_IP1553_Print_Errors(uint32_t errors)
{
    if ( (errors & IP1553_INT_MASK_MTE) == IP1553_INT_MASK_MTE )
        printf("  Error :  R/W memory transfer error has occurred.\r\n");
    if ( (errors & IP1553_INT_MASK_TE) == IP1553_INT_MASK_TE )
        printf("  Error : Error has occurred during processing of the reception, transmission, or transfer.\r\n");
    if ( (errors & IP1553_INT_MASK_TCE) == IP1553_INT_MASK_TCE )
        printf("  Error : Manchester code error has been detected on a word that has been received.\r\n");
    if ( (errors & IP1553_INT_MASK_TPE) == IP1553_INT_MASK_TPE )
        printf("  Error : Parity error has been detected on a received word.\r\n");
    if ( (errors & IP1553_INT_MASK_TDE) == IP1553_INT_MASK_TDE )
        printf("  Error : Data word has been received when a command word was expected and vice-versa.\r\n");
    if ( (errors & IP1553_INT_MASK_TTE) == IP1553_INT_MASK_TTE )
        printf("  Error : Response time of the addressed terminal is greater than expected or that the response is missing.\r\n");
    if ( (errors & IP1553_INT_MASK_TWE) == IP1553_INT_MASK_TWE )
        printf("  Error : The number of words received does not correspond to the number of words expected.\r\n");
    if ( (errors & IP1553_INT_MASK_BE) == IP1553_INT_MASK_BE )
        printf("  Error : A data word transmission has been stopped because data have not been provided in time on the Buffer interface.\r\n");
    if ( (errors & IP1553_INT_MASK_ITR) == IP1553_INT_MASK_ITR )
        printf("  Error : The transfer which has been commanded via the command IF is not legal and will not be performed.\r\n");
}

// *****************************************************************************
// *****************************************************************************
// Section: Main Entry Point
// *****************************************************************************
// *****************************************************************************

int main(void)
{
    /* Initialize all modules */
    SYS_Initialize(NULL);

    printf("\n\r-----------------------------------------------------------");
    printf("\n\r  IP1553 - RT mode blocking operation example              ");
    printf("\n\r-----------------------------------------------------------\n\r");

    /* Set buffers Configuration */
    IP1553_BuffersConfigSet(&IP1553TxBuffersRAM[0][0], &IP1553RxBuffersRAM[0][0]);

    /* Reset Tx and Rx status for buffers 0, 1, 2, 3 and 31 */
    IP1553_ResetTxBuffersStatus(APP_IP1553_BUFFER_USED);
    IP1553_ResetRxBuffersStatus(APP_IP1553_BUFFER_USED);

    /* Prepare content in buffers to send*/
    for (uint8_t i = 0; i < IP1553_BUFFERS_NUM; i++)
    {
        for (uint8_t j = 0; j < IP1553_BUFFERS_SIZE; j++)
        {
            IP1553TxBuffersRAM[i][j] = (i << 12) + (j + 1);
        }
    }

    printf("\n\rMIL1553 RT mode, wait for BC commands\r\n");

    while ( true )
    {
        uint32_t status = IP1553_IrqStatusGet();

        /* Check if there was error during transfer */
        if ( status & IP1553_INT_MASK_ERROR_MASK )
        {
            APP_IP1553_Print_Errors(status);
        }

        if ( (status & IP1553_INT_MASK_ERX) == IP1553_INT_MASK_ERX )
        {
            uint32_t lastActiveBuffers = (~(IP1553_GetRxBuffersStatus())) & APP_IP1553_BUFFER_USED;
            uint32_t buffer = 0;
            while ( lastActiveBuffers != 0 )
            {
                while ( ( lastActiveBuffers & 0x1 ) == 0 )
                {
                    buffer++;
                    lastActiveBuffers >>= 1;
                }

                printf("RX buffer : %u", (unsigned int) buffer);
                for (uint8_t index = 0; index < 32; index++)
                {
                    if ( (index % 8) == 0 )
                        printf("\r\n    ");
                    else
                        printf(" ,");
                    printf("0x%04X", IP1553RxBuffersRAM[buffer][index]);
                }
                printf("\r\n");

                /*Reset Rx buffer content */
                memset(&IP1553RxBuffersRAM[buffer][0], 0, IP1553_BUFFERS_SIZE);

                /* Reset Rx buffer status */
                IP1553_ResetRxBuffersStatus(IP1553_BUFFER_TO_BITFIELD_SA(buffer));

                /* Go to next bit in lastActiveBuffer bit field */
                buffer++;
                lastActiveBuffers >>= 1;
            }
        }

        if ( (status & IP1553_INT_MASK_ETX) == IP1553_INT_MASK_ETX )
        {
            uint32_t lastActiveBuffers = (~(IP1553_GetTxBuffersStatus())) & APP_IP1553_BUFFER_USED;
            uint32_t buffer = 0;
            while ( lastActiveBuffers != 0 )
            {
                while ( ( lastActiveBuffers & 0x1 ) == 0 )
                {
                    buffer++;
                    lastActiveBuffers >>= 1;
                }

                /* Reset Tx buffer status */
                IP1553_ResetTxBuffersStatus(IP1553_BUFFER_TO_BITFIELD_SA(buffer));

                printf("TX buffer reset: %u\r\n", (unsigned int) buffer);

                /* Go to next bit in lastActiveBuffer bit field */
                buffer++;
                lastActiveBuffers >>= 1;
            }
        }
    }

    /* Execution should not come here during normal operation */

    return (EXIT_FAILURE);
}

/*******************************************************************************
 End of File
 */

