app_data = {
    cars: [
        { weight: 620,   pic: 'images/cars/taksikoer.jpg',      url: 'taksikoer',   texts: { 'ee': 'Sõiduauto TAKSIKOER',  'ru': 'пассажирского TAKSIKOER',  'fi': 'Henkilöauto TAKSIKOER',  'lv': "Pasažieru taksis",  'gb': 'Passenger dachshund',  'de': 'Passenger Dackel'}},
        { weight: 710,   pic: 'images/cars/ET - 600.jpg',       url: 'ET-600',      texts: { 'ee': 'Väikeveok ET - 600',  'ru': 'Малая Жесткие EN - 600 ',  'fi': 'pienkuljetukset FI - 600',  'lv': "Mazais Rigid LV - 600",  'gb': 'Small Rigid EN - 600 ', 'de': 'Kleine Starre EN - 600 '}},
        { weight: 850,   pic: 'images/cars/M-401.jpg',          url: 'M-401',       texts: { 'ee': 'Sõiduauto M-401 ',  'ru': 'автомобиль М-401 ',  'fi': 'Henkilöauto M-401',  'lv': "Transportlīdzekļu M-401",  'gb': 'Vehicle M-401',  'de': "Fahrzeug-M-401"}},
//        { weight: 1400, pic: 'images/cars/image_missing.png',   url: 'D-455',       texts: { 'ee': 'Mootorvibrorull D - 455',  'ru': 'Mootorvibrorull D - 455 ',  'fi': 'Mootorvibrorull D - 455',  'lv': "Mootorvibrorull D - 455",  'gb': 'Mootorvibrorull D - 455 ',  'de': 'Mootorvibrorull D - 455 '}},
        { weight: 1420, pic: 'images/cars/GAZ-24-01.jpg',       url: 'GAZ-24',      texts: { 'ee': 'GAZ-24',  'ru': 'ГАЗ-24',  'fi': 'GAZ-24 ',  'lv': "GAZ-24",  'gb': 'GAZ-24',  'de': "GAZ-24"}},
        { weight: 1810, pic: 'images/cars/GAZ-MM.jpg',          url: 'GAZ-MM',      texts: { 'ee': 'Veoauto GAZ-MM',  'ru': 'Грузовик ГАЗ-ММ',  'fi': 'Kuorma GAZ-MM',  'lv': "kravas automašīna GAZ-MM",  'gb': 'Truck GAZ-MM', 'de': 'LKW GAZ-MM'}},
        { weight: 2500, pic: 'images/cars/GAZ-51A.jpg',         url: 'GAZ-51A',     texts: { 'ee': 'Veoauto GAZ-51A',  'ru': 'Грузовик ГАЗ-51А',  'fi': 'Kuorma GAZ-51A',  'lv': "kravas automašīna GAZ-51A",  'gb': 'Truck GAZ-51A',  'de': 'LKW GAZ-51A'}},
        { weight: 2540, pic: 'images/cars/Caterpillar.jpg',     url: 'Caterpillar', texts: { 'ee': 'Haakehöövel Caterpillar',  'ru': 'Haakehöövel Caterpillar',  'fi': 'Haakehöövel Caterpillar',  'lv': "Haakehöövel Caterpillar",  'gb': 'Haakehöövel Caterpillar',  'de': 'Haakehöövel Caterpillar'}},
//        { weight: 3075, pic: 'images/cars/image_missing.png',   url: 'D-241',       texts: { 'ee': 'Haakehöövel D-241',  'ru': 'Haakehöövel D-241 ',  'fi': 'Haakehöövel D-241',  'lv': "Haakehöövel D-241",  'gb': 'Haakehöövel D-241 ', 'de': 'Haakehöövel D-241 '}},
        { weight: 3700, pic: 'images/cars/SD-105A.jpg',         url: 'SD-105A',     texts: { 'ee': 'Poolhaagishöövel SD-105A',  'ru': 'Poolhaagishöövel SD-105A',  'fi': 'Poolhaagishöövel SD-105A',  'lv': "Poolhaagishöövel SD-105A",  'gb': 'Poolhaagishöövel SD-105A',  'de': 'Poolhaagishöövel SD-105A'}},
        { weight: 6300, pic: 'images/cars/DU-50.png',           url: 'DU-50',       texts: { 'ee': 'Mootorrull DU-50',  'ru': 'Mootorrull DU-50',  'fi': 'Mootorrull DU-50',  'lv': "Mootorrull DU-50 ",  'gb': 'Mootorrull DU-50',  'de': 'Mootorrull DU-50'}},
        { weight: 6500, pic: 'images/cars/MAZ 200.png',         url: 'MAZ-200',     texts: { 'ee': 'Veoauto MAZ 200',  'ru': 'Грузовик МАЗ 200',  'fi': 'Kuorma MAZ 200',  'lv': "Kravas MAZ 200",  'gb': 'Truck MAZ 200',  'de': 'LKW MAZ 200 '}},
        { weight: 7400, pic: 'images/cars/DE-5.png',            url: 'DE-5',        texts: { 'ee': 'Teeremondimasin DE-5',  'ru': 'Дорожно-ремонтные машины DE-5',  'fi': 'Teeremondimasin DE-5',  'lv': "Ceļu remonts mašīnas DE-5",  'gb': 'Road-repair Machine DE-5', 'de': 'Road-Reparatur-Maschine DE-5'}},
        { weight: 8500, pic: 'images/cars/D-598A.jpg',          url: 'D-598A',      texts: { 'ee': 'Teehöövel D-598A',  'ru': 'D-598A Грейдер',  'fi': 'Teehöövel D-598A',  'lv': "D-598A greiders ",  'gb': 'D-598A Grader',  'de': 'D-598a Grader'}},
        { weight: 9250, pic: 'images/cars/D-512.jpg',           url: 'D-512',       texts: { 'ee': 'Liikurhöövel D-512',  'ru': 'Liikurhöövel D-512 ',  'fi': 'Liikurhöövel D-512',  'lv': "Liikurhöövel D-512",  'gb': 'Liikurhöövel D-512 ',  'de': 'Liikurhöövel D-512 '}},
        { weight: 10600, pic: 'images/cars/V-10.png',           url: 'V-10',        texts: { 'ee': 'Liikurhöövel V-10',  'ru': 'Liikurhöövel V-10',  'fi': 'Liikurhöövel V-10',  'lv': "Liikurhöövel V-10",  'gb': 'Liikurhöövel V-10',  'de': 'Liikurhöövel V-10'}},
        { weight: 10890, pic: 'images/cars/Sauer.png',          url: 'Saurer',      texts: { 'ee': 'Autobuss Saurer',  'ru': 'Автобус Saurer',  'fi': 'linja-auto Saurer',  'lv': "Autobuss Saurer",  'gb': 'Bus Saurer',  'de': 'Bus Saurer'}},
        { weight: 11000, pic: 'images/cars/KDM-130A.png',       url: 'KDM-130A',    texts: { 'ee': 'Liivapuistur KDM 130A',  'ru': 'пескоразбрасыватель KDM 130А',  'fi': 'liivapuistur KDM 130A',  'lv': "smilšu kaisītājs KDM 130A",  'gb': 'gritter KDM 130A',  'de': 'Sandstreuer TDM 130A'}},
        { weight: 13400, pic: 'images/cars/D-144.png',          url: 'D-144',       texts: { 'ee': 'Teehöövel D-144',  'ru': 'Грейдер Д-144 ',  'fi': 'Teehöövel D-144',  'lv': "greiders D-144",  'gb': 'Grader D-144 ',  'de': 'Grader D-144 '}},
        { weight: 19500, pic: 'images/cars/image_missing.png',  url: 'DZ-98',       texts: { 'ee': 'Liikurhöövel DZ-98 B',  'ru': 'Liikurhöövel ДЗ-98 B',  'fi': 'Liikurhöövel DZ-98 B',  'lv': "Liikurhöövel DZ-98 B",  'gb': 'DZ-98 Liikurhöövel B',  'de': 'Liikurhöövel DZ-98 B'}}
        
    ],
    languages: [ 
        { code: 'ee', 'index': 5 },
        { code: 'ru', 'index': 4 },
        { code: 'gb', 'index': 3 },
        { code: 'fi', 'index': 2 },
        { code: 'lv', 'index': 1 },
        { code: 'de', 'index': 0 }
    ],        
    messages: {
        'ee': {
            'algusesse': 'Algusesse',
            'sinu_kaal': 'Sinu kaal:',
            'arvuta': 'Arvuta',
            'kg': 'kg',
            'teade': 'Sinu kaal kokkupõrkel ',
            'info': 'Vaata kuidas sinu "kaal" muutub sõltuvalt auto kiirusest.  ',
            'welcome': 'Vali oma kaal ja vajuta "Arvuta" nupule'
            
        }, 'ru': {
            'algusesse': 'Назад',
            'sinu_kaal': 'Ваш вес:',
            'arvuta': 'Рассчитать',
            'kg': 'кг',
            'teade': 'Ваш вес на скорости ',
            'info': 'Vaata kuidas sinu "kaal" muutub sõltuvalt auto kiirusest.  ',
            'welcome': 'Выберите свой ​​вес и нажмите на кнопку "Рассчитать"'

        }, 'fi': {
            'algusesse': 'Alkuun',
            'sinu_kaal': 'Sinun paino:',
            'arvuta': 'Laske',
            'kg': 'kg',
            'teade': 'Sinun paino nopeudella ',
            'info': 'Vaata kuidas sinu "kaal" muutub sõltuvalt auto kiirusest.  ',
            'welcome': 'Valitse painon ja klikkaa "Laske"-painiketta'

        }, 'lv': {
            'algusesse': 'Sākumu',
            'sinu_kaal': 'Jūsu Svars:',
            'arvuta': 'Aprēķināt',
            'kg': 'kg',
            'teade': 'Jūsu svars ātrumu ',
            'info': 'Vaata kuidas sinu "kaal" muutub sõltuvalt auto kiirusest.  ',
            'welcome': 'Izvēlieties savu svaru un noklikšķiniet uz "Aprēķināt" pogu'
            
        }, 'gb': {
            'algusesse': 'Start again',
            'sinu_kaal': 'Your weight:',
            'arvuta': 'Calculate',
            'kg': 'kg',
            'teade': 'Your weight at impact ',
            'info': 'See how your weight changes while driving a car at different speeds.',
            'welcome': 'Select your weight and click on "Calculate" button'
        }, 'de': {
			'algusesse': 'Erneut Start',
            'sinu_kaal': 'Ihr Gewicht:',
            'arvuta': 'Berechnen',
            "kg": "kg",
            'teade': 'Ihr Gewicht beim aufprall ',
            'info': 'Vaata kuidas sinu "kaal" muutub sõltuvalt auto kiirusest.  ',
            'welcome': 'Wählen Sie Ihr Gewicht ein und klicken Sie auf "Berechnen"'
		}
	}
}
    