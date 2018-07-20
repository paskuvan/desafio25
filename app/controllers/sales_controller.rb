class SalesController < ApplicationController
  def new
    @sale = Sale.new
  end

  def create
    sale = Sale.new(sale_params)
    prepare_sale(sale)
    redirect_to sales_done_path
  end

  def done
    @sale = Sale.all.last
  end

private
def sale_params
  params.require(:sale).permit(:detail, :category, :value, :discount, :tax)
end

def prepare_sale(sale)
  sale.cod = Random.rand(10...100000)
  sale.value = (sale_params[:value].to_i) * (100 - sale_params[:discount].to_i)
  if sale_params[:tax].to_i == 0
    sale.total = sale.value * 1.19
    sale.tax = 19
  else
    sale.tax = 0
    sale.total = sale.value
  end
    
   sale.save
 end
end