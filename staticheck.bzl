SA1 = [
  "SA1000",
  "SA1001",
  "SA1002",
]

SA2 = [
  "SA2000",
  "SA2001",
  "SA2002",
]

STATICCHECK_ANALYZERS = SA1 + SA2

STATICCHECK_OVERRIDE = {
  "SA1000": {
    "exclude_files": {
      "external/": "third_party",
    }
  },
  "shadow": {
    "exclude_files": {
      "external/": "third_party",
      "/": "",
    }
  },
  "unsafeptr": {
    "exclude_files": {
      "external/": "third_party",
    }
  },
}
