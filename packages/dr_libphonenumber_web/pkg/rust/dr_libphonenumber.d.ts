declare namespace wasm_bindgen {
	/* tslint:disable */
	/* eslint-disable */
	/**
	* @param {string} phone_number
	* @param {string} iso_code
	* @param {number} phone_number_format
	* @returns {any}
	*/
	export function wire_format(phone_number: string, iso_code: string, phone_number_format: number): any;
	/**
	* @param {string} phone_number
	* @param {string} iso_code
	* @returns {any}
	*/
	export function wire_get_number_type(phone_number: string, iso_code: string): any;
	/**
	* @param {number} calling_code
	* @returns {any}
	*/
	export function wire_get_region_code_for_country_code(calling_code: number): any;
	/**
	* @param {string} phone_number
	* @param {string} iso_code
	* @returns {any}
	*/
	export function wire_get_region_info(phone_number: string, iso_code: string): any;
	/**
	* @param {string} phone_number
	* @param {string} iso_code
	* @returns {any}
	*/
	export function wire_is_valid_phone_number(phone_number: string, iso_code: string): any;
	/**
	* ## Safety
	* This function reclaims a raw pointer created by [`TransferClosure`], and therefore
	* should **only** be used in conjunction with it.
	* Furthermore, the WASM module in the worker must have been initialized with the shared
	* memory from the host JS scope.
	* @param {number} payload
	* @param {any[]} transfer
	*/
	export function receive_transfer_closure(payload: number, transfer: any[]): void;
	/**
	* # Safety
	*
	* TODO: need doc
	* @param {number} ptr
	* @returns {any}
	*/
	export function get_dart_object(ptr: number): any;
	/**
	* # Safety
	*
	* TODO: need doc
	* @param {number} ptr
	*/
	export function drop_dart_object(ptr: number): void;
	/**
	*/
	export function run_hooks(): void;
	/**
	*/
	export class WorkerPool {
	  free(): void;
	/**
	* Creates a new `WorkerPool` which immediately creates `initial` workers.
	*
	* The pool created here can be used over a long period of time, and it
	* will be initially primed with `initial` workers. Currently workers are
	* never released or gc'd until the whole pool is destroyed.
	*
	* # Errors
	*
	* Returns any error that may happen while a JS web worker is created and a
	* message is sent to it.
	* @param {number} initial
	* @param {string} script_src
	*/
	  constructor(initial: number, script_src: string);
	}
	
}

declare type InitInput = RequestInfo | URL | Response | BufferSource | WebAssembly.Module;

declare interface InitOutput {
  readonly memory: WebAssembly.Memory;
  readonly free_memory: (a: number) => void;
  readonly wire_format: (a: number, b: number, c: number, d: number, e: number) => number;
  readonly wire_get_number_type: (a: number, b: number, c: number, d: number) => number;
  readonly wire_get_region_code_for_country_code: (a: number) => number;
  readonly wire_get_region_info: (a: number, b: number, c: number, d: number) => number;
  readonly wire_is_valid_phone_number: (a: number, b: number, c: number, d: number) => number;
  readonly __wbg_workerpool_free: (a: number) => void;
  readonly workerpool_new: (a: number, b: number, c: number, d: number) => void;
  readonly run_hooks: () => void;
  readonly receive_transfer_closure: (a: number, b: number, c: number, d: number) => void;
  readonly get_dart_object: (a: number) => number;
  readonly drop_dart_object: (a: number) => void;
  readonly __wbindgen_malloc: (a: number, b: number) => number;
  readonly __wbindgen_realloc: (a: number, b: number, c: number, d: number) => number;
  readonly __wbindgen_export_2: WebAssembly.Table;
  readonly _dyn_core__ops__function__FnMut__A____Output___R_as_wasm_bindgen__closure__WasmClosure___describe__invoke__h0126a4834d6666aa: (a: number, b: number, c: number) => void;
  readonly __wbindgen_add_to_stack_pointer: (a: number) => number;
  readonly __wbindgen_exn_store: (a: number) => void;
  readonly __wbindgen_free: (a: number, b: number, c: number) => void;
  readonly __wbindgen_start: () => void;
}

/**
* If `module_or_path` is {RequestInfo} or {URL}, makes a request and
* for everything else, calls `WebAssembly.instantiate` directly.
*
* @param {InitInput | Promise<InitInput>} module_or_path
*
* @returns {Promise<InitOutput>}
*/
declare function wasm_bindgen (module_or_path?: InitInput | Promise<InitInput>): Promise<InitOutput>;
