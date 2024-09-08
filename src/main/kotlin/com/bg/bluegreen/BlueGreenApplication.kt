package com.bg.bluegreen

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class BlueGreenApplication

fun main(args: Array<String>) {
    runApplication<BlueGreenApplication>(*args)
}
