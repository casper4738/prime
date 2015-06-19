package prime.constants;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;

public interface Constants {
	//##A.Task Handling
	static interface Task {
		static final String BACKTOMAIN 	= "t1";
		static final String GOTOEDIT	= "t2";
		static final String DOEDIT 	 	= "t3";
		static final String GOTOADD 	= "t4";
		static final String DOADD 	 	= "t5";
		static final String DODELETE 	= "t6";
		static final String CHANGELANG 	= "t7";
		static final String NONE		= "t8";
		static final String GOTOMANAGER = "t9";
	}

	//##B.Search Handling
	static interface Search {
		static final Map<String, String> DIVISION_SEARCHCOLUMNS = Collections.unmodifiableMap(
	        new LinkedHashMap<String, String>() {{
	        	put("SHOW_ALL", "SHOW ALL");
	        	put("NAME", "DIVISION NAME");
	        }
	    });
		static final Map<String, String> POSITION_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("SHOW_ALL", "SHOW ALL");
				put("NAME", "DIVISION NAME");
			}
		});
		static final Map<String, String> ROLE_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("SHOW_ALL", "SHOW ALL");
				put("NAME", "ROLE NAME");
			}
		});
		static final Map<String, String> HOLIDAY_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("SHOW_ALL", "SHOW ALL");
				put("DESCRIPTION", "DECRIPTION HOLIDAY");
			}
		});
	}

	//##C.Page Handling
	static final Map<Integer, Integer> PAGINGROWPAGE = Collections.unmodifiableMap(
		new LinkedHashMap<Integer, Integer>() {{
        	put(5,   5);
        	put(10,  10);
        	put(25,  25);
        	put(50,  50);
        	put(100, 100);
        }
	});
	public static final int MAX_PAGE_PERSHOW = 5;
	
	//##D.Standard Value
	//##1.Standard Status Value
	static interface Status {
		static Integer RECEIVE  = 0;
		static Integer PROGRESS = 1;
		static Integer PAUSE    = 2;
		static Integer SUBMIT   = 3;
		static Integer FINISH   = 4;
		static Integer ABORT    = 5;
	}
	
	//##2.Standard Day Conversion
	static interface Day {
		static Integer MONDAY    = 0;
		static Integer TUESDAY   = 1;
		static Integer WEDNESDAY = 2;
		static Integer THURSDAY  = 3;
		static Integer FRIDAY 	 = 4;
		static Integer SATURDAY  = 5;
		static Integer SUNDAY	 = 6;
	}
		

}
