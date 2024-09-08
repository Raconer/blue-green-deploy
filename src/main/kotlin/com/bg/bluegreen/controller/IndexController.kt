package com.bg.bluegreen.controller

import org.slf4j.LoggerFactory
import org.springframework.context.ApplicationContext
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class IndexController (
    private val ctx : ApplicationContext
){

    private val log = LoggerFactory.getLogger(IndexController::class.java)

    @GetMapping
    fun index() : String{

        val env = this.ctx.environment
        val deployType = env.getProperty("deploy.type")?:"UNKNOWN DEPLOY TYPE"

        this.log.info(":::: Start Get Log : ${deployType} ::::")

        return "Deploy ${deployType}"
    }

}