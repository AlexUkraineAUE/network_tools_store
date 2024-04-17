ActiveAdmin.register SiteContent do
  actions :all, except: [:destroy]
  permit_params :content

  form do |f|
    f.inputs "Site Content" do
      f.input :name, input_html: { readonly: true }
      f.input :content, as: :text, input_html: { rows: 10}
    end
    f.actions
  end
end
