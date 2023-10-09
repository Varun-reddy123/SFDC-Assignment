global class ScheduleCountryCallout implements Schedulable {
   global void execute(SchedulableContext SC) {
      ExternalCountryServiceCallout.getCountryDetails(); 
       }
}