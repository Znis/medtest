class Category {
  Category({
    this.title = '',
    this.id = 0,
    this.imagePath = '',
    this.money = 0,
    this.description = '',
    // this.rating = 0.0,
  });
  int id;
  String title;
  String description;
  int money;
  // double rating;
  String imagePath;

  static List<Category> categoryListBasics = <Category>[
    Category(
      imagePath: 'assets/testimages/lipid-test.png',
      title: 'Lipid Profile',
      id : 0,
      money: 25,
      description:
'A lipid panel is a blood test that measures the amount of certain fat molecules called lipids in your blood. In most cases, the panel includes four different cholesterol measurements and a measurement of your triglycerides.',  
    ),

 
    Category(
      imagePath: 'assets/testimages/vitd-test.png',
      title: 'Vitamin D Test',
      money: 25,
      id: 2,
      description:
'Vitamin D test provides insight of the possible gaps of your nutrition and support in making better food choices to nourish your body. Vitamin D plays a significant factor in bone health.',   
    ),
   
    
  ];
  static List<Category> categoryListBlood = <Category>[
      Category(
      imagePath: 'assets/testimages/lipid-test.png',
      title: 'Lipid Profile',
      id : 0,
      money: 25,
      description:
'A lipid panel is a blood test that measures the amount of certain fat molecules called lipids in your blood. In most cases, the panel includes four different cholesterol measurements and a measurement of your triglycerides.',      // rating: 4.3,
    ),
    Category(
      imagePath: 'assets/testimages/blood-test.png',
      title: 'Blood Test',
      id: 1,
      description:
'A blood test is a lab analysis of things that may be found in your blood. You may have blood tests to keep track of how well you are managing a condition such as diabetes or high cholesterol. ',
      money: 18,
    
    ),
 

   
  ];
  static List<Category> categoryListHormone = <Category>[
      Category(
      imagePath: 'assets/testimages/lipid-test.png',
      title: 'Lipid Profile',
      id : 0,
      money: 25,
      description:
'A lipid panel is a blood test that measures the amount of certain fat molecules called lipids in your blood. In most cases, the panel includes four different cholesterol measurements and a measurement of your triglycerides.',     
    ),
   
 
    Category(
      imagePath: 'assets/testimages/vitd-test.png',
      title: 'Vitamin D Test',
      money: 25,
      id: 2,
      description:
'Vitamin D test provides insight of the possible gaps of your nutrition and support in making better food choices to nourish your body. Vitamin D plays a significant factor in bone health.',   
  
    ),
   
  ];

  static List<Category> popularCourseList = <Category>[
       Category(
      imagePath: 'assets/testimages/lipid-test.png',
      title: 'Lipid Profile',
      id : 0,
      money: 25,
      description:
'A lipid panel is a blood test that measures the amount of certain fat molecules called lipids in your blood. In most cases, the panel includes four different cholesterol measurements and a measurement of your triglycerides.',      // rating: 4.3,
    ),
    Category(
      imagePath: 'assets/testimages/blood-test.png',
      title: 'Blood Test',
      id: 1,
      description:
'A blood test is a lab analysis of things that may be found in your blood. You may have blood tests to keep track of how well you are managing a condition such as diabetes or high cholesterol. ',
      money: 18,
    
    ),
 
    Category(
      imagePath: 'assets/testimages/vitd-test.png',
      title: 'Vitamin D Test',
      money: 25,
      id: 2,
      description:
'Vitamin D test provides insight of the possible gaps of your nutrition and support in making better food choices to nourish your body. Vitamin D plays a significant factor in bone health.',   
    ),
   
  ];
}
