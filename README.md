# APB Protocol Verification using SystemVerilog

## Overview

This project implements verification of the APB (Advanced Peripheral Bus) protocol using SystemVerilog. The project validates APB transactions and protocol behavior using a transaction-based verification environment with assertions.

## Features

* APB slave implementation
* Generator
* Driver
* Monitor
* Scoreboard
* Interface-based communication
* SystemVerilog Assertions (SVA)
* Read and write transaction verification

## Project Structure

apb_checker.sv → Assertion checker module
bind_file.sv → Binds assertions to DUT
driver.sv → Drives transactions to DUT
generator.sv → Generates stimulus
monitor.sv → Captures DUT activity
scoreboard.sv → Compares expected vs actual output
transaction.sv → Transaction class definition
apb_if.sv → Interface definition
apb_slave.sv → APB slave DUT
tb.sv → Top testbench
files.f → Compilation file list

## Simulation Tool

Cadence Incisive / irun

## Verification Flow

Generator → Driver → DUT → Monitor → Scoreboard

## Results

The APB protocol behavior was verified for transaction flow and protocol correctness using assertions and simulation waveforms.
