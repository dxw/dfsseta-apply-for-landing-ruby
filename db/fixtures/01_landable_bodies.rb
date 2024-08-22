[
  {
    id: "f869e63d-3ce5-4480-b8ac-3eb0c266f659",
    name: "Mars",
    active: true
  },
  {
    id: "56f498b9-3b76-4ce8-9f3e-8a9ef20594f3",
    name: "Saturn (core)",
    active: true
  },
  {
    id: "11bced89-eb9c-4163-ad9e-c3cb89d6745c",
    name: "International Space Station (ESA)",
    active: true
  },
  {
    id: "bd41bc58-044b-4841-b159-219b091f68f2",
    name: "Tiangong space station",
    active: true
  },
  {
    id: "5db88724-cb68-431f-a7c6-6f08347458f4",
    name: "Earth's moon",
    active: true
  },
  {
    id: "21c97e41-ca50-4549-9892-36196d602a0f",
    name: "Pluto",
    active: true
  }
].each do |body|
  LandableBody.seed(:id) do |s|
    s.id = body[:id]
    s.name = body[:name]
    s.active = body[:active]
  end
end
