package model;

/**
 * Model of user information blanks, inherited from question.
 * @author LZTR
 *
 */
public class UserInfoBlank extends Question{

	public UserInfoBlank() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UserInfoBlank(int id, String stem, boolean isMust) {
		super(id, stem, "UserInfoBlank", isMust);
		// TODO Auto-generated constructor stub
	}
	
}
