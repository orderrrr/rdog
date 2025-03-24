#!/bin/bash
rm app.tracy
tracy-capture -o app.tracy && tracy app.tracy
