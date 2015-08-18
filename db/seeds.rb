User.destroy_all

users = User.create [
  {
    email: "chas@munat.com",
    password: "12345"
  },
  {
    email: "joe@munat.com",
    password: "1234"
  }
]
