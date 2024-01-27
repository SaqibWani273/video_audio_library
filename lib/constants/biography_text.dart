const String biographyText =
    "Shaykh Noorul Hasan Madani Hafidhulllah was born in Maunath Bhanjan a village of Uttar Pradesh, India, in the year 1970 C.E. His father is Abul Hasan.After his return from Madinah the Shaykh went on to complete his Masters degree in Arabic from The Delhi University. He is NET certified from The University Grants Commission (UGC)He studied the basics of reading and writing, when young from his village. He enrolled into the Jamia Darussalam Omrabad in the year 1984 and completed Fazilath from there. He graduated with a degree in hadeeth (Hadeeth Honour) in the year 1993, an example of how he valued his time can be known from the fact that the Shaykh completed two degrees while at the jamiah, the second being a bachelors degree in education (B.Ed).He studied with a number of scholars in different fields, and from amongst the well-known are:Shaykh Abdul Mohsin Al Abaad.Shaykh Abdullah Gunaiman.Shaykh Ziyaur Rahman Azami.Shaykh Abdul Azeez Al Abdul LateefLater he was appointed as a teacher in Jamia Islamia - Sanaabil at Delhi. In the last 20 years he has taught amongst various other books Sahih Ul Bukhari, Sahih ul Muslim and Tirmizi. Currently the Shaykh teaches Hadeeth and Uloom Ul Hadeeth in Kullyath ul Hadeeth in Banglore.The respected Shaykh is currently teachingSaheeh ul Bukhari at Masjid E Abu Bakr, Bangalore, India.Jami' ul Uloom wal Hikam at Masjid E Salafiyah, Bangalore, IndiaHe has also participated in many conferences like Rabe Ta’tul Jamit al Islamiyah, Islamic University League, Taleem E Umoor with Saleem al Hilaalee, Umar Al Ashqar, Abdul Hameed Rahmanee and othersHe is on the Consultation panel of many educational Institutes to interview and appoint the teachers.Inspite of his many responsibilities and busy schedule the respected Shaykh has not only shared his knowledge for the students of universities but also for the laymen. He has taught subjects like Tafseer Ul Qur'aan, Allaah's Names and Attributes, Aqeedatul Wasitiyah, Usool ul Hadeeth, Usool ut Tafseer, Al Qawaid al Fiqhiyah, Fiqh, Women Tarbiyah, Seerah, Bulooghul Maraam etc.";

class Biography {
  static String intro =
      "Shaykh Noorul Hasan Madani Hafidhulllah was born in Maunath Bhanjan a village of Uttar Pradesh, India, in the year 1970 C.E. His father is Abul Hasan.";
  static String education =
      "He studied the basics of reading and writing, when young from his village. He enrolled into the Jamia Darussalam Omrabad in the year 1984 and completed Fazilath from there. He graduated with a degree in hadeeth (Hadeeth Honour) in the year 1993, an example of how he valued his time can be known from the fact that the Shaykh completed two degrees while at the jamiah, the second being a bachelors degree in education (B.Ed)";
  static String afterEducationText =
      "After his return from Madinah the Shaykh went on to complete his Masters degree in Arabic from The Delhi University. He is NET certified from The University Grants Commission (UGC).\nHe studied with a number of scholars in different fields, and from amongst the well-known are:";
  static String teachersOfSheikh =
      "\nShaykh Abdul Mohsin Al Abaad.\nShaykh Abdullah Gunaiman.\nShaykh Ziyaur Rahman Azami.\nShaykh Abdul Azeez Al Abdul Lateef.\n";
  static String teachings =
      "Later he was appointed as a teacher in Jamia Islamia - Sanaabil at Delhi. In the last 20 years he has taught amongst various other books Sahih Ul Bukhari, Sahih ul Muslim and Tirmizi. Currently the Shaykh teaches Hadeeth and Uloom Ul Hadeeth in Kullyath ul Hadeeth in Banglore.\nThe respected Shaykh is currently teaching\n -> Saheeh ul Bukhari at Masjid E Abu Bakr, Bangalore, India.\n -> Jami' ul Uloom wal Hikam at Masjid E Salafiyah, Bangalore, India.";
}

Map<String, String> getBiography() {
  return {
    "introduction": Biography.intro,
    "education":
        "${Biography.education}\n${Biography.afterEducationText}\n${Biography.teachersOfSheikh}",
    "teachings": Biography.teachings,
    "Compiled by": "Centre for Quraan And Sunnah, Bangalore.",
  };
}
