function sysCall_init()
    corout=coroutine.create(coroutineMain)
end

function sysCall_actuation()
    if coroutine.status(corout)~='dead' then
        local ok,errorMsg=coroutine.resume(corout)
        if errorMsg then
            error(debug.traceback(corout,errorMsg),2)
        end
    end
end

function sysCall_cleanup()
    -- do some clean-up here
end


function getHandleOfObject(objectName)
    object_handle = sim.getObjectHandle(objectName)
    return object_handle
end

function getPositionOfObject(objectName)
    object_handle = getHandleOfObject(objectName)
    object_position = sim.getObjectPosition(object_handle, -1)
    return object_position
end

function setVelocity(motorName, velocity)
    sim.setJointTargetVelocity(motorName, velocity)
end

function getTime()
    time = sim.getSimulationTime()
    return time
end

function coroutineMain()

    handles()
    
    --gains
    Kp = 0  --Kp
    Ki = 0  --Ki
    Kd = 0  --Kd
    
    --target
    pi = 3.1415926535
    ref_theta = pi
    ref_theta_dot = 0
    
    error = 0  --initial error
    
    while true do
        
        ----------------------------------------------------------------------------------------------
        -- Determine the error angle
        
        
        -- error
        
        ----------------------------------------------------------------------------------------------
        -- Write the equations wrt the error
        
        --Proportional
        kp_error = 0
        --Integral
        ki_error = 0
        --Derivative
        kd_error = 0

        ----------------------------------------------------------------------------------------------
        -- P+I+D equation
        torque = Kp*kp_error + Ki*ki_error + Kd*kd_error

        ----------------------------------------------------------------------------------------------
        -- Set velocity to the motor by giving obtained torque value as the required velocity to move the motor

        ----------------------------------------------------------------------------------------------
        
    end
    
end


---------------------------------------------------------------------------------------------------
--[[
    HINTS:
        1. Determine the error angle (comparing the refernce angle and current angle).
        2. Determine the P, I, D controller equations seperately (without the gain values).
        3. Add P + I + D.
        4. Set torque to the reaction wheel.
        
    ]]-- 



---------------------------------------------------------------------------------------------------

-- See the user manual or the available code snippets for additional callback functions and details
