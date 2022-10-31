class RuleManagementsController < ApplicationController
  def new
    @form = RuleManagementForm.new
  end

  def create
    @form = RuleManagementForm.new(rule_management_params)

    if @form.save
      redirect_to rule_managements_path
    else
      render :new
    end
  end

  def edit
    load_rule

    @form = RuleManagementForm.new(rule: @rule, )
  end

  def update
    load_rule

    @form = RuleManagementForm.new(rule_management_params, rule: @rule)

    if @form.save
      redirect_to @rule
    else
      render :edit
    end
  end

  private

  def rule_management_params
    params.require(:rule).permit(:rule_name, 
      read: {
        service_ids: []
        },
      write: {
        service_ids: []
        }
      )
  end

  def load_rule
    @rule = Rule.find(params[:id])
  end
end
 