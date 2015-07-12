class WechatDonateController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create, :notify]
  skip_before_action :authenticate_user!, :only => [:create, :notify]

  def form_list
    @formdata = WxDonateForm.all
  end

  def create
    # address: "adr"amount: "1"company: "NKU"donator: "匿名"email: "em"message: "msg"pnone: 
    # "152"postcode: "300071"project_id: "0"project_sub_id: "0"relation_id: "0"relation_sub_id: "0"
    # school_info: "12121212"sex: "0" cert: 2, receipt: 1
    # "jsApiPar"=>{"appId"=>"wx0aed2861054c5ac3", 
    #   "nonceStr"=>"wilnrecn2qdy4464effhj0k6o1ykg23z", 
    #   "package"=>"prepay_id=wx2015071300125776b371623f0608707980", 
    #   "signType"=>"MD5", "timeStamp"=>1436717577, 
    #   "paySign"=>"2FCC6F5E5AA7F0BBC4BE7E45C549E8C2"}, 
    #   "out_trade_no"=>"124998810120150713001257",
    #    "wechat_donate"=>{"formData"=>{"donator"=>"匿名", "amount"=>"0.1"}, "jsApiPar"=>{"appId"=>"wx0aed2861054c5ac3", "nonceStr"=>"wilnrecn2qdy4464effhj0k6o1ykg23z", "package"=>"prepay_id=wx2015071300125776b371623f0608707980", "signType"=>"MD5", "timeStamp"=>1436717577, "paySign"=>"2FCC6F5E5AA7F0BBC4BE7E45C549E8C2"}, "out_trade_no"=>"124998810120150713001257"}}
    # p request
    puts params
    formData = params[:formData]
    form = WxDonateForm.new({
      donator: formData[:donator],
      wx_donate_project_id: formData[:project_id],
      wx_donate_project_sub_id: formData[:project_sub_id],
      amount: formData[:amount],
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
      out_trade_no: params[:jsApiPar][:out_trade_no],
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
