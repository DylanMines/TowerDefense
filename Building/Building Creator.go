components {
  id: "build"
  component: "/Building/build.script"
}
embedded_components {
  id: "factory"
  type: "factory"
  data: "prototype: \"/tower/tower.go\"\n"
  "load_dynamically: true\n"
  ""
}
