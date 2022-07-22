# FLEXRAMECC_OBJ

```c
typedef struct
{
    /* Transfer Event Callback for Fixable Error interrupt*/
    FLEXRAMECC_CALLBACK fix_callback;

    /* Transfer Event Callback Context for Fixable Error interrupt*/
    uintptr_t fix_context;

    /* Transfer Event Callback for NoFixable Error interrupt*/
    FLEXRAMECC_CALLBACK nofix_callback;

    /* Transfer Event Callback Context for NoFixable Error interrupt*/
    uintptr_t nofix_context;
} FLEXRAMECC_OBJ;
```

**Summary**

 FLEXRAMECC PLib Object structure.

**Description**

 This data structure defines the FLEXRAMECC PLib Instance Object.
