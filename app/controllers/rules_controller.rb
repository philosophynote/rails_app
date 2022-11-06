class RulesController < ApplicationController
  def index
    @rules = Rule.all
  end

  def new
    @form = RuleForm.new
  end

  def create
    @form = RuleForm.new(rule_params)

    if @form.save
      redirect_to rules_path
    else
      render :new
    end
  end

  def edit
    load_rule

    @form = RuleForm.new(rule: @rule)
  end

  def update
    load_rule
    @form = RuleForm.new(rule_params, rule: @rule)

    if @form.save
      redirect_to rules_path
    else
      render :edit
    end
  end

  private

  def rule_params
    params.require(:rule).permit(:rule_name, 
      read: {
        services: []
        },
      write: {
        services: []
        }
      )
  end

  def load_rule
    @rule = Rule.find(params[:id])
  end
end
 