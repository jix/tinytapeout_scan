# Formal Equivalence Check for the TinyTapeout Scan Chain

To perform an equivalence check to the reference netlists scan_wrapper_one.v and scan_wrapper_zero.v, copy `<module_name>.v` into this repository and run `sby -f
tinytapeout_scan.sby <module_name>`. The name of the module and the filename must match.

Two working example netlists are included:

```
sby -f tinytapeout_scan.sby scan_wrapper_339501025136214612
sby -f tinytapeout_scan.sby scan_wrapper_340805072482992722
```

As well as four examples that break the scan chain in different ways:

```
sby -f tinytapeout_scan.sby scan_wrapper_data_as_clock
sby -f tinytapeout_scan.sby scan_wrapper_invert
sby -f tinytapeout_scan.sby scan_wrapper_too_short
sby -f tinytapeout_scan.sby scan_wrapper_stealthy
```

If Yosys complains about missing modules, most likely more synthesizable models of some PDK primitives need to be added to `needed_primitives.sv`.
