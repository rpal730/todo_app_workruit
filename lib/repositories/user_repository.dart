class UserRepository {


	Future<void> addUser({
		required String userId,
		required String email,
		required String name
	}) async {
		await DatabaseClient.provider.addUser(
			uid: userId, 
			name: name, 
			email: email
		);
	}



  


}