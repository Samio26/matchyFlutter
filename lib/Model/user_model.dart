

class Users {
final int id;
final String nom;
final String prenom;
final String bio;
final String imgUrl;
final List<String> interests;
final List<String> objectifs;
final String jobTitre;
final String placeJob;
final String formation;
const Users({required this.id, required this.nom, required this.prenom,
required this.bio,required this.imgUrl, required this.interests,required this.objectifs,required this.jobTitre,required this.placeJob,required this.formation});
  @override
  // TODO: implement props
  List<Object?> get props => [
id,nom,prenom,bio,imgUrl,interests,objectifs,jobTitre,placeJob,formation
  ];

  static List<Users> User=[
      
      Users(
        id:1,
        nom:"Sami",
        prenom:"aissa",
        bio:"ddd",
        imgUrl:"https://i.pinimg.com/originals/c3/77/81/c3778165f5536e67e84b4dc06ecdb0f4.jpg",
        interests:[
          "Develomeent",
          "Sports",
          "E-commerce",
        ],
        objectifs:[
          "freelance",
          "job",
        ],
        jobTitre:"developpeur",
        placeJob:"sousse",
        formation:"ddd"
      ),
        
      Users(
        id:1,
        nom:"Wael",
        prenom:"aissa",
        bio:"ddd",
        imgUrl:"https://i.pinimg.com/originals/c3/77/81/c3778165f5536e67e84b4dc06ecdb0f4.jpg",
        interests:[
          "Develomeent",
          "Sports",
          "E-commerce",
        ],
        objectifs:[
          "freelance",
          "job",
        ],
        jobTitre:"developpeur",
        placeJob:"sousse",
        formation:"ddd"
      )
   
  ];
}
