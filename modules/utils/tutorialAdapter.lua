-------------------------------------------
-- entSpawner - Tutorial Adapter
-- WindowUtils is optional; all calls become no-ops if absent
-------------------------------------------

local tutorialAdapter = {}

local wu = nil
local scopedApi = nil
local reportBounds = nil

function tutorialAdapter.init()
    wu = GetMod("WindowUtils")
    if not wu then
        return false
    end

    if wu.Tutorial and wu.Tutorial.forMod then
        scopedApi = wu.Tutorial.forMod("entSpawner", {
            windows = { "World Builder" }
        })
    end

    if wu.ReportBounds then
        reportBounds = wu.ReportBounds
    end

    return scopedApi ~= nil
end

---@return boolean
function tutorialAdapter.isAvailable()
    return scopedApi ~= nil
end

---@param elementId string
---@param padRight number|nil
function tutorialAdapter.report(elementId, padRight)
    if reportBounds then
        reportBounds(elementId, padRight)
    end
end

---@param definition table
---@return boolean
function tutorialAdapter.register(definition)
    if not scopedApi then return false end
    return scopedApi:register(definition)
end

---@param tutorialId string
---@return boolean
function tutorialAdapter.start(tutorialId)
    if not scopedApi then return false end
    return scopedApi:start(tutorialId)
end

---@param tutorialId string
function tutorialAdapter.stop(tutorialId)
    if scopedApi then
        scopedApi:stop(tutorialId)
    end
end

---@param tutorialId string
---@return boolean
function tutorialAdapter.isActive(tutorialId)
    if not scopedApi then return false end
    return scopedApi:isActive(tutorialId)
end

---@param tutorialId string
---@return boolean
function tutorialAdapter.isCompleted(tutorialId)
    if not scopedApi then return false end
    return scopedApi:isCompleted(tutorialId)
end

---@param tutorialId string
function tutorialAdapter.resetCompletion(tutorialId)
    if scopedApi then
        scopedApi:resetCompletion(tutorialId)
    end
end

---@return boolean
function tutorialAdapter.isGroupEnabled()
    if not scopedApi then return true end
    return scopedApi:isGroupEnabled()
end

---@param enabled boolean
function tutorialAdapter.setGroupEnabled(enabled)
    if scopedApi then
        scopedApi:setGroupEnabled(enabled)
    end
end

return tutorialAdapter
