local Players      = game:GetService("Players")
local UIS          = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RS           = game:GetService("ReplicatedStorage")
local HttpService  = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")

local LP = Players.LocalPlayer
local CONFIG_FILE = "IceHubLaggerOmahad_Config.json"

-- ============ THEME ============
local ICE_BLUE    = Color3.fromRGB(0, 170, 255)
local ICE_CYAN    = Color3.fromRGB(0, 255, 255)
local ICE_DEEP    = Color3.fromRGB(0, 90, 180)
local BG_BLACK    = Color3.fromRGB(6, 8, 12)
local BG_PANEL    = Color3.fromRGB(12, 16, 24)
local BG_INPUT    = Color3.fromRGB(20, 28, 40)
local BG_HOVER    = Color3.fromRGB(30, 42, 60)
local TEXT_WHITE  = Color3.fromRGB(240, 248, 255)
local TEXT_DIM    = Color3.fromRGB(130, 150, 175)
local TEXT_GLOW   = Color3.fromRGB(100, 220, 255)
local STROKE_BLUE = Color3.fromRGB(30, 80, 140)

-- ============ SFX ============
local sfxFolder = Instance.new("Folder")
sfxFolder.Name = "IceHubSFX"
sfxFolder.Parent = SoundService

local function makeSfx(name, id, vol, pitch)
    local s = Instance.new("Sound")
    s.Name = name
    s.SoundId = "rbxassetid://" .. tostring(id)
    s.Volume = vol or 0.5
    s.PlaybackSpeed = pitch or 1
    s.Parent = sfxFolder
    return s
end

local SFX = {
    Click     = makeSfx("Click",     9114282417, 0.35, 1.0),
    Hover     = makeSfx("Hover",     9114294822, 0.15, 1.4),
    Start     = makeSfx("Start",     9114300981, 0.55, 0.9),
    Stop      = makeSfx("Stop",      9114303932, 0.45, 0.75),
    Toggle    = makeSfx("Toggle",    9114307441, 0.40, 1.2),
    Keybind   = makeSfx("Keybind",   9114310303, 0.40, 1.6),
    Saved     = makeSfx("Saved",     9114313755, 0.40, 1.3),
    Error     = makeSfx("Error",     9114316718, 0.40, 0.6),
}

local function playSfx(name)
    local s = SFX[name]
    if not s then return end
    s:Stop()
    s:Play()
end

-- ============ GUI ============
local gui = Instance.new("ScreenGui")
gui.Name = "IceHubLaggerOmahad"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999
gui.Parent = LP:WaitForChild("PlayerGui")

local Main = Instance.new("Frame", gui)
Main.Size = UDim2.new(0, 320, 0, 340)
Main.Position = UDim2.new(0.5, -160, 0.5, -170)
Main.BackgroundColor3 = BG_BLACK
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 16)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = STROKE_BLUE
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.1
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local MainGrad = Instance.new("UIGradient", Main)
MainGrad.Rotation = 135
MainGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 14, 22)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(4, 6, 10)),
}

-- ============ ANIMATED SNOW / ICE PARTICLES ============
local Particles = Instance.new("Frame", Main)
Particles.Size = UDim2.new(1, 0, 1, 0)
Particles.BackgroundTransparency = 1
Particles.ZIndex = 0
Particles.ClipsDescendants = true
Instance.new("UICorner", Particles).CornerRadius = UDim.new(0, 16)

local function spawnFlake()
    local dot = Instance.new("Frame", Particles)
    local size = math.random(1, 4)
    dot.Size = UDim2.new(0, size, 0, size)
    dot.BackgroundColor3 = (math.random(1, 2) == 1) and ICE_CYAN or TEXT_WHITE
    dot.BackgroundTransparency = math.random(55, 90) / 100
... (530 lines left)