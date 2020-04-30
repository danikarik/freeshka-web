# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

top_level_cities = City.create([
                                 { name: 'Нур-Султан' },
                                 { name: 'Алматы' },
                                 { name: 'Шымкент' },
                                 { name: 'Акмолинская область' },
                                 { name: 'Актюбинская область' },
                                 { name: 'Алматинская область' },
                                 { name: 'Атырауская область' },
                                 { name: 'Восточно-Казахстанская область' },
                                 { name: 'Жамбылская область' },
                                 { name: 'Западно-Казахстанская область' },
                                 { name: 'Карагандинская область' },
                                 { name: 'Костанайская область' },
                                 { name: 'Кызылординская область' },
                                 { name: 'Мангистауская область' },
                                 { name: 'Павлодарская область' },
                                 { name: 'Северо-Казахстанская область' },
                                 { name: 'Туркестанская область' }
                               ])

cities = City.create([
                       { name: 'Кокшетау', parent: top_level_cities[3] },
                       { name: 'Актобе', parent: top_level_cities[4] },
                       { name: 'Талдыкорган', parent: top_level_cities[5] },
                       { name: 'Атырау', parent: top_level_cities[6] },
                       { name: 'Усть-Каменогорск', parent: top_level_cities[7] },
                       { name: 'Тараз', parent: top_level_cities[8] },
                       { name: 'Уральск', parent: top_level_cities[9] },
                       { name: 'Уральск', parent: top_level_cities[10] },
                       { name: 'Костанай', parent: top_level_cities[11] },
                       { name: 'Кызылорда', parent: top_level_cities[12] },
                       { name: 'Актау', parent: top_level_cities[13] },
                       { name: 'Павлодар', parent: top_level_cities[14] },
                       { name: 'Петропавловск', parent: top_level_cities[15] },
                       { name: 'Туркестан', parent: top_level_cities[16] }
                     ])

categories = Category.create([{ name: 'Услуги' }])

subcategories = Category.create([{ name: 'Реклама', parent: categories[0] },
                                 { name: 'Дизайн', parent: categories[0] },
                                 { name: 'Разработка', parent: categories[0] }])

org_forms = OrgForm.create([{ name: 'ТОО', label: 'ТОО' },
                            { name: 'ИП', label: 'ИП' },
                            { name: 'ФЛ', label: 'ФЛ' }])
