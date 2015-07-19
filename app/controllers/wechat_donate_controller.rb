class WechatDonateController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create, :notify]
  skip_before_action :authenticate_user!, :only => [:create, :notify]

  def form_list
    @formdata = WxDonateForm.all
  end

  def create
    puts params
    formData = params[:formData]
    form = WxDonateForm.new({
      donator: formData[:donator],
      wx_donate_project_id: formData[:project_id],
      wx_donate_project_sub_id: formData[:project_sub_id],
      amount: formData[:amount]*100,
      gender: formData[:gender],
      email: formData[:email],
      phone: formData[:phone],
      address: formData[:address],
      postcode: formData[:postcode],
      company: formData[:company],
      nk_relation_id: formData[:relation_id],
      nk_relation_sub_id: formData[:relation_sub_id],
      school_info: formData[:school_info],
      message: formData[:message],
      need_cert: formData[:cert],
      need_receipt: formData[:receipt],
      out_trade_no: params[:out_trade_no],
      openid: params[:openid],
      notify_flag: nil
    })
    form.save
    render :nothing => true
  end

  def notify
    xml = params[:notify_xml]
    h = Hash.from_xml(xml)
    render :nothing => true
  end
end
