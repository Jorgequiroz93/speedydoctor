class ReportsController < ApplicationController

    
    def create
      @consultation = Consultation.find(params[:consultation_id])
      @report =  Report.new(report_params)
      @report.consultation = @consultation
      if @report.save
        redirect_to consultation_report_path(@consultation, @report) #Indicate the path and the arguments
      else
       render 'consultations/show' #Controller/action
      end

    end

    private

    def report_params
      params.require(:report).permit(:content, :prescription)
    end

end
