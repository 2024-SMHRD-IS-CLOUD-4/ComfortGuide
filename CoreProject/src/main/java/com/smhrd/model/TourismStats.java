package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class TourismStats {

	String referenceMonth;
    int visitorCount;
    int visitorCountLastYear;
    double visitorCountGrowthRate;
    int tourismExpenditure;
    int tourismExpenditureLastYear;
    double tourismExpenditureGrowthRate;
	
}
