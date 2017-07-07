package model;


import java.util.ArrayList;
import java.util.List;

/**
 * Model of multiple choice, inherited from question, also including options for choice 
 * and the range of valid number of options which can be chosen.
 * @author LZTR
 *
 */
public class MultipleChoice extends Question{
	private List<String> options=new ArrayList<String>();//Options
	private int minOpt;//Min of the number of options
	private int maxOpt;//Max of the number of options
	
	public MultipleChoice() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public MultipleChoice(int id, String stem, String type, boolean isMust, List<String> options, int minOpt,
			int maxOpt) {
		super(id, stem, type, isMust);
		this.options = options;
		this.minOpt = minOpt;
		this.maxOpt = maxOpt;
	}


	public List<String> getOptions() {
		return options;
	}

	public void setOptions(List<String> options) {
		this.options = options;
	}

	public int getMinOpt() {
		return minOpt;
	}

	public void setMinOpt(int minOpt) {
		this.minOpt = minOpt;
	}

	public int getMaxOpt() {
		return maxOpt;
	}

	public void setMaxOpt(int maxOpt) {
		this.maxOpt = maxOpt;
	}

}
