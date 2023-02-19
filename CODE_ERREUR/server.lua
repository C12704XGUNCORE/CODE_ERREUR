local function HandleError(errorMessage)
    Citizen.Trace("[CLIENT ERROR] " .. errorMessage .. "\n")
end

-- Rediriger les erreurs vers HandleError
debug.sethook(function(...)
    local message = debug.traceback(..., 2)
    HandleError(message)
end, "", 0)



function RedirectClientErrorsToServer()
    local oldprint = print
  
    print = function(...)
      local args = {...}
      local message = table.concat(args, " ")
      TriggerServerEvent("custom:redirectClientError", message)
      oldprint(...)
    end
  end
  
  RedirectClientErrorsToServer()
  
  RegisterNetEvent("custom:redirectClientError")
AddEventHandler("custom:redirectClientError", function(message)
  print("[Client Error] " .. message)
end)
