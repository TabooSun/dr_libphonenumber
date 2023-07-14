#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
typedef struct _Dart_Handle* Dart_Handle;

typedef struct DartCObject DartCObject;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

typedef struct DartCObject *WireSyncReturn;

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

void store_dart_post_cobject(DartPostCObjectFnType ptr);

Dart_Handle get_dart_object(uintptr_t ptr);

void drop_dart_object(uintptr_t ptr);

uintptr_t new_dart_opaque(Dart_Handle handle);

intptr_t init_frb_dart_api_dl(void *obj);

WireSyncReturn wire_format(struct wire_uint_8_list *phone_number,
                           struct wire_uint_8_list *iso_code,
                           int32_t phone_number_format);

WireSyncReturn wire_get_number_type(struct wire_uint_8_list *phone_number,
                                    struct wire_uint_8_list *iso_code);

WireSyncReturn wire_get_region_code_for_country_code(uint16_t calling_code);

WireSyncReturn wire_get_region_info(struct wire_uint_8_list *phone_number,
                                    struct wire_uint_8_list *iso_code);

WireSyncReturn wire_is_valid_phone_number(struct wire_uint_8_list *phone_number,
                                          struct wire_uint_8_list *iso_code);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void free_WireSyncReturn(WireSyncReturn ptr);

void free_memory(void *unsafe_struct);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_format);
    dummy_var ^= ((int64_t) (void*) wire_get_number_type);
    dummy_var ^= ((int64_t) (void*) wire_get_region_code_for_country_code);
    dummy_var ^= ((int64_t) (void*) wire_get_region_info);
    dummy_var ^= ((int64_t) (void*) wire_is_valid_phone_number);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturn);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    return dummy_var;
}
