class JobsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_client, only: [:new, :create, :my_jobs]
    before_action :check_freelancer, only: [:index, :search, :apply]
  
    def index
        if current_user.freelancer?
          skills = current_user.freelancer_profile.skills.split(',').map(&:strip)
          @jobs = Job.where(
            skills.map { |skill| "skills_required LIKE ?" }.join(' OR '),
            *skills.map { |skill| "%#{skill}%" }
          )
        end
      end
  
    def new
      @job = current_user.hiring_client_profile.jobs.new
    end
  
    def create
      @job = current_user.hiring_client_profile.jobs.new(job_params)
      if @job.save
        redirect_to my_jobs_jobs_path, notice: 'Job posted successfully!'
      else
        render :new
      end
    end
  
    def my_jobs
      @jobs = current_user.hiring_client_profile.jobs
    end
  
    def search
        if params[:search].present?
          search_term = "%#{params[:search].downcase}%"
          @jobs = Job.where("LOWER(title) LIKE ? OR LOWER(description) LIKE ?", search_term, search_term)
        else
          @jobs = Job.all
        end
      end

    def apply
      job = Job.find(params[:id])
      application = job.applications.new(freelancer_profile_id: current_user.freelancer_profile.id, status: 'applied')
      
      if application.save
        # Create notification for client
        Notification.create(
          recipient: job.hiring_client_profile.user,
          sender: current_user,
          message: "#{current_user.username} applied for your job: #{job.title}",
          notification_type: 'job_application',
          read: false
        )
        redirect_to jobs_path, notice: 'Application submitted!'
      else
        redirect_to jobs_path, alert: 'Error submitting application'
      end
    end
  
    def hire
      application = Application.find(params[:id])
      if application.update(status: 'hired')
        # Create notification for freelancer
        Notification.create(
          recipient: application.freelancer_profile.user,
          sender: current_user,
          message: "You've been hired for #{application.job.title} by #{current_user.username}",
          notification_type: 'hired',
          read: false
        )
        redirect_to my_jobs_path, notice: 'Freelancer hired!'
      else
        redirect_to my_jobs_path, alert: 'Error hiring freelancer'
      end
    end
  
    private
  
    def job_params
      params.require(:job).permit(:title, :description, :requirements, :salary, :skills_required)
    end
  
    def check_client
      unless current_user.hiring_client?
        redirect_to root_path, alert: 'Only hiring clients can access this page'
      end
    end
  
    def check_freelancer
      unless current_user.freelancer?
        redirect_to root_path, alert: 'Only freelancers can access this page'
      end
    end
  end