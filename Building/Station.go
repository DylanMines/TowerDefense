embedded_components {
  id: "Tower"
  type: "sprite"
  data: "default_animation: \"Level1\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "blend_mode: BLEND_MODE_ALPHA\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/Building/StationSprites.tilesource\"\n"
  "}\n"
  ""
  position {
    x: 0.0
    y: 0.0
    z: 1.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
}
embedded_components {
  id: "Range"
  type: "sprite"
  data: "default_animation: \"range\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "blend_mode: BLEND_MODE_ADD\n"
  "size {\n"
  "  x: 150.0\n"
  "  y: 150.0\n"
  "  z: 0.0\n"
  "  w: 0.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/Building/Station.atlas\"\n"
  "}\n"
  ""
  position {
    x: 0.0
    y: 0.0
    z: 1.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
}
