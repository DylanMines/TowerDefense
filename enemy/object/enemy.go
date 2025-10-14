components {
  id: "death"
  component: "/enemy/resources/death.particlefx"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"Regular_Enemy\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "playback_rate: 3.0\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/enemy/resources/enemies.atlas\"\n"
  "}\n"
  ""
  scale {
    x: 0.5
    y: 0.5
  }
}
