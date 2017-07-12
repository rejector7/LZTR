package dao;

import model.AnswerSheet;

public interface AnswerSheetDao {

	void addAnswerSheet(AnswerSheet ans);

	void deleteAnswerSheet(AnswerSheet ans);

	void updateAnswerSheet(AnswerSheet ans);

	public AnswerSheet getAnswerSheetById(int id);

}