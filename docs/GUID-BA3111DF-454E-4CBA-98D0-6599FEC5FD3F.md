# SPW_PKTTX_PREV

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
