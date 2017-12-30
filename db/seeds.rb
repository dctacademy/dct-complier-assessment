# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Role.create(name: "admin")
Role.create(name: "contributor")
Role.create(name: "solver")
Role.create(name: "moderator")
Role.create(name: "student")

u = User.create(email: "admin@gmail.com", username: "admin", password: "secret123")
u.roles.push(Role.first)

Course.create(name: "web development")
Course.create(name: "mean stack")

s1 = Student.create(name: "1", email: "1@gmail.com", mobile: "1111111111")
s1.courses.push(Course.first)
s2 = Student.create(name: "2", email: "2@gmail.com", mobile: "2222222222")
s2.courses.push(Course.first)
s3 = Student.create(name: "3", email: "3@gmail.com", mobile: "3333333333")
s3.courses.push(Course.first)
s4 = Student.create(name: "4", email: "4@gmail.com", mobile: "4444444444")
s4.courses.push(Course.last)
s5 = Student.create(name: "5", email: "5@gmail.com", mobile: "5555555555")
s5.courses.push(Course.last)

batch = Batch.create(title: "August Batch", start_date: Date.today - 3.months, end_date: Date.today + 1.month, course_id: Course.first.id, is_completed: false)

batch.students.push(Student.all)

Assignment.create(title: "The Hashtag Generator", body: "generate hash tag" )
Assignment.create(title: "Add 2 numbers", body: "add 2 + 2")

