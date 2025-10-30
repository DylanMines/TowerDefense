components {
  id: "tower"
  component: "/tower/tower.script"
}
components {
  id: "tower_window"
  component: "/tower/tower.gui"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"Level 1\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/tower/resources/tower_images.atlas\"\n"
  "}\n"
  ""
  position {
    z: 1.0
  }
}
embedded_components {
  id: "range"
  type: "sprite"
  data: "default_animation: \"range\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "blend_mode: BLEND_MODE_ADD\n"
  "size {\n"
  "  x: 150.0\n"
  "  y: 150.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/tower/resources/tower_images.atlas\"\n"
  "}\n"
  ""
  position {
    z: 1.0
  }
}
