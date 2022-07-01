using Gridap
using Gridap.Fields
using Gridap.Polynomials
using Gridap.Helpers

using GLMakie, Makie
using Makie: hbox!, vbox!

# This Makie script plots 1D Modal vs 1D Lagrangian FE basis funs:
#
# In the [0,1] _fixed_ domain, we plot the FEs in [ξ₀,ξ₁] ⊆ [0,1] 
# and see how the shapefun values extrapolate from [ξ₀,ξ₁] to [0,1].
# We can perturb the [ξ₀,ξ₁] with Makie sliders.
#
# Versions: (Gridap v0.17.12, Makie v0.17.8, GLMakie v0.6.8)

# Create figure and axes
fig = Figure( resolution = (900, 600), backgroundcolor = RGBf(0.99, 0.99, 0.99) )

axM = Axis(fig[1,1])
axL = Axis(fig[1,2])

cols = [:red, :blue, :green, :orange, :purple]
lins = [nothing, :dash, :dot, :dashdot, :dashdotdot]

# FE order is an Observable that can be selected from a deployable menu
maxod = 4 # Plotting shape funs up to order 4
order = [1,2,3,4]
od = Observable{Int64}(order[2]) # Default order = 2
menu = Menu(fig, options = zip(["q = 1","q = 2","q = 3","q = 4"], order))
menu.direction = :up

# Interval [ξ₀,ξ₁] of FE can be perturbed with a slider
ξ = collect(0.0:0.25:1.0)
s1 = Slider(fig,range=1:length(ξ),startvalue=1,
            color_inactive=RGBf(1.0,1.0,1.0))
s2 = Slider(fig,range=1:length(ξ),startvalue=1,
            color_inactive=RGBf(1.0,1.0,1.0))

# Evaluate all FE basis functions that the user can play with in the plot
x = collect(0.0:0.02:1.0)
xp = [Fields.Point(i) for i in x]

CIs = CartesianIndices((1:length(ξ),1:length(ξ)))

T = Float64
dataM = zeros(T,length(ξ),length(ξ),length(x),maxod+1)
dataL = zeros(T,length(ξ),length(ξ),length(x),maxod+1,maxod)
emptydata = zeros(T,length(x))

for ci in CIs

  ci[1] ≥ ci[2] && continue
  ξ₀=Fields.Point(ξ[ci[1]])
  ξ₁=Fields.Point(ξ[ci[2]])

  orders = tfill(maxod,Val(1))
  b = ModalC0Basis{1}(T,orders,ξ₀,ξ₁)
  dataM[ci,:,:] = evaluate(b,xp)

  domain = (ξ[ci[1]],ξ[ci[2]])
  partition = (1,)
  model = CartesianDiscreteModel(domain,partition)
  for o in 1:maxod
    fe_cell = FiniteElements(PhysicalDomain(),model,lagrangian,T,o)
    V = FESpace(model,fe_cell)
    dv = get_fe_basis(V)
    dataL[ci,:,1:o+1,o] = evaluate(dv.cell_basis[1],xp)
  end

end

# Reactive plots of FE basis functions
for oid in 1:maxod+1

  dataMbx = lift(s1.value,s2.value,od) do iξ₀,iξ₁,od
    if oid ≤ od[]+1
      x
    else
      emptydata
    end
  end

  dataMby = lift(s1.value,s2.value,od) do iξ₀,iξ₁,od
    if oid ≤ od[]+1
      dataM[iξ₀,iξ₁,:,oid]
    else
      emptydata
    end
  end
  
  lines!(axM,dataMbx,dataMby,color=cols[oid],linestyle=lins[oid],linewidth=2)

  dataLbx = lift(s1.value,s2.value,od) do iξ₀,iξ₁,od
    if oid ≤ od[]+1
      x
    else
      emptydata
    end
  end
  
  dataLby = lift(s1.value,s2.value,od) do iξ₀,iξ₁,od
    if oid ≤ od[]+1
      dataL[iξ₀,iξ₁,:,oid,od]
    else
      emptydata
    end
  end
  
  lines!(axL,dataLbx,dataLby,color=cols[oid],linestyle=lins[oid],linewidth=2)

end

# Static and reactive plots to show [ξ₀,ξ₁] and [0,1]
dataIx = [0.0,1.0]
dataIy = [0.0,0.0]
lines!(axM,dataIx,dataIy,color=:gray,linewidth=1.0)
lines!(axL,dataIx,dataIy,color=:gray,linewidth=1.0)
scatter!(axM,dataIx,dataIy,markersize=6,color=:black,strokewidth=0.0)
scatter!(axL,dataIx,dataIy,markersize=6,color=:black,strokewidth=0.0)
dataIx = lift(s1.value,s2.value) do iξ₀,iξ₁
    [ξ[iξ₀],ξ[iξ₁]]
end
dataIy = [0.0,0.0]
lines!(axM,dataIx,dataIy,color=:black,linewidth=1.5)
lines!(axL,dataIx,dataIy,color=:black,linewidth=1.5)
scatter!(axM,dataIx,dataIy,color=:orange,markersize=10)
scatter!(axL,dataIx,dataIy,color=:orange,markersize=10)

# Plot legend, labels, etc.
line1 = lines!(axM,(0,0),color=cols[1],linestyle=lins[1],linewidth=2)
line2 = lines!(axM,(0,0),color=cols[2],linestyle=lins[2],linewidth=2)
line3 = lines!(axM,(0,0),color=cols[3],linestyle=lins[3],linewidth=2)
line4 = lines!(axM,(0,0),color=cols[4],linestyle=lins[4],linewidth=2)
line5 = lines!(axM,(0,0),color=cols[5],linestyle=lins[5],linewidth=2)

axM.xticks = 0.0:0.1:1.0
axM.xlabel="ξ"
axM.ylabel="φ(ξ)"
axM.title="Modal 1D Basis"

axL.xticks = 0.0:0.1:1.0
axL.xlabel="ξ"
axL.ylabel="φ(ξ)"
axL.title="Lagrangian 1D Basis"

axM.xticksize = 2.0; axM.yticksize = 2.0
axM.xticklabelsize = 12.0; axM.yticklabelsize = 12.0

axL.xticksize = 2.0; axL.yticksize = 2.0
axL.xticklabelsize = 12.0; axL.yticklabelsize = 12.0

legmarkers = [ line1, line2, line3, line4, line5 ]
legnames = [ "φ₁", "φ₂", "φ₃", "φ₄", "φ₅" ]
leg = Legend( fig, legmarkers, legnames )
error = (x,y) -> x < y ? " " : "ERROR! ξ₁ ≤ ξ₀"
fig[2, :] = hbox!( vbox!( Label(fig, "Order", width = nothing),
      menu, tellheight = false, width = 200 ), vbox!(
      Label(fig, lift(x -> "ξ₀: $(ξ[x])",s1.value), width = nothing), s1,
      Label(fig, lift(x -> "ξ₁: $(ξ[x])",s2.value), width = nothing), s2 ),
      Label(fig, lift(error,s1.value,s2.value), width = 150), leg )

# Trigger events when sliders or menu value are updated
on(s1.value) do s
  autolimits!(axM)
  autolimits!(axL)
end

on(s2.value) do s
  autolimits!(axM)
  autolimits!(axL)
end

on(menu.selection) do s
  od[] = s
  autolimits!(axM)
  autolimits!(axL)
end

# Open interactive figure
fig