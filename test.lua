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

function handles()
    pivotJoint_handle = sim.getObjectHandle('Pivot')
    pendulumString_handle = sim.getObjectHandle('PendulumString')
    pendulum_handle = sim.getObjectHandle('Pendulum')
    pendulumMotor_handle = sim.getObjectHandle('PendulumMotor')
end

function getPositionOfObject(objectName)
    object_handle = sim.getObjectHandle(objectName)
    object_position = sim.getObjectPOsition(object_handle, -1)
end

function coroutineMain()

    handles()
    
    --METHOD 1
    -- --gains
    gain1 = 3700  --Kp
    gain2 = 1   --Kd
    gain3 = 60    --Ki   

    --METHOD 2
    --gains
    -- gain1 = 1900  --Kp
    -- gain2 = 5    --Ki
    -- gain3 = 150    --Kd   
    
    --target
    pi = 3.1415926535
    ref_theta = pi
    ref_theta_dot = 0
    
    pendulum_position_initial = sim.getObjectPosition(pendulum_handle, -1)
    time_prev = sim.getSimulationTime()
    error = 0

    -- METHOD 2
    -- count = 0
    -- error_old = 0
    
    while true do
        pendulum_position = sim.getObjectPosition(pendulum_handle, -1)
        
        theta = math.acos((pendulum_position[2] - pendulum_position_initial[2])/0.3) + 1.57
        theta_dot = sim.getJointVelocity(pivotJoint_handle)

        error1 = theta - ref_theta
        
        error2 = error1 + error

        -- METHOD 1
        error3 = theta_dot - ref_theta_dot

        -- METHOD 2
        -- error_new = error1
        -- if (count%20 == 0) then
        --     time_now = sim.getSimulationTime()
        --     error3 = (error_new - error_old) /(time_now - time_prev)
        -- end


        ----------------------------------------------------------------
        torque = gain1*error1 + gain2*error2 + gain3*error3
        print(torque)
        ---------------------------------------------------------------- 
        
        -- METHOD 2
        -- error_old = error_new
        -- time_prev = time_now

        error = error2
        
        velocity = torque
        
        sim.setJointTargetVelocity(pendulumMotor_handle, velocity)
        
        -- METHOD 2
        -- count = count+ 1
        
    end
    
end

-- See the user manual or the available code snippets for additional callback functions and details
