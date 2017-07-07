package model;

/**
 * Model of subjective question,inherited from question.
 * @author LZTR
 *
 */
public class SubjectiveQuestion extends Question{

	public SubjectiveQuestion() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SubjectiveQuestion(int id, String stem, boolean isMust) {
		super(id, stem, "subjectiveQuestion", isMust);
		// TODO Auto-generated constructor stub
	}
	
}
