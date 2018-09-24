package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.cloudant.client.api.CloudantClient;
import com.cloudant.client.api.Database;
import wasdev.sample.Customer;
import wasdev.sample.District;
import wasdev.sample.Order;
import wasdev.sample.Warehouse;
import wasdev.sample.store.CloudantItemStore;
import wasdev.sample.store.DBClient;
import wasdev.sample.store.Transaction;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());

		ArrayList<String> infoList = new ArrayList<>();
		ArrayList<String> iidList = new ArrayList<>();
		ArrayList<String> widList = new ArrayList<>();
		ArrayList<String> cntList = new ArrayList<>();

		String wid = request.getParameter("wid");
		String did = request.getParameter("did");
		String cid = request.getParameter("cid");

		infoList.add(wid);
		infoList.add(did);
		infoList.add(cid);

		String iid1 = request.getParameter("iid1");
		if(iid1.length()>0) iidList.add(iid1);
		String iid2 = request.getParameter("iid2");
		if(iid2.length()>0) iidList.add(iid2);
		String iid3 = request.getParameter("iid3");
		if(iid3.length()>0) iidList.add(iid3);
		String iid4 = request.getParameter("iid4");
		if(iid4.length()>0) iidList.add(iid4);
		String iid5 = request.getParameter("iid5");
		if(iid5.length()>0) iidList.add(iid5);
		String iid6 = request.getParameter("iid6");
		if(iid6.length()>0) iidList.add(iid6);
		String iid7 = request.getParameter("iid7");
		if(iid7.length()>0) iidList.add(iid7);
		String iid8 = request.getParameter("iid8");
		if(iid8.length()>0) iidList.add(iid8);
		String iid9 = request.getParameter("iid9");
		if(iid9.length()>0) iidList.add(iid9);
		String iid10 = request.getParameter("iid10");
		if(iid10.length()>0) iidList.add(iid10);
		String iid11 = request.getParameter("iid11");
		if(iid11.length()>0) iidList.add(iid11);
		String iid12 = request.getParameter("iid12");
		if(iid12.length()>0) iidList.add(iid12);
		String iid13 = request.getParameter("iid13");
		if(iid13.length()>0) iidList.add(iid13);
		String iid14 = request.getParameter("iid14");
		if(iid14.length()>0) iidList.add(iid14);
		String iid15 = request.getParameter("iid15");
		if(iid15.length()>0) iidList.add(iid15);



		String wid1 = request.getParameter("wid1");
		if(wid1.length()>0) widList.add(wid1);
		String wid2 = request.getParameter("wid2");
		if(wid2.length()>0) widList.add(wid2);
		String wid3 = request.getParameter("wid3");
		if(wid3.length()>0) widList.add(wid3);
		String wid4 = request.getParameter("wid4");
		if(wid4.length()>0) widList.add(wid4);
		String wid5 = request.getParameter("wid5");
		if(wid5.length()>0) widList.add(wid5);
		String wid6 = request.getParameter("wid6");
		if(wid6.length()>0) widList.add(wid6);
		String wid7 = request.getParameter("wid7");
		if(wid7.length()>0) widList.add(wid7);
		String wid8 = request.getParameter("wid8");
		if(wid8.length()>0) widList.add(wid8);
		String wid9 = request.getParameter("wid9");
		if(wid9.length()>0) widList.add(wid9);
		String wid10 = request.getParameter("wid10");
		if(wid10.length()>0) widList.add(wid10);
		String wid11 = request.getParameter("wid11");
		if(wid11.length()>0) widList.add(wid11);
		String wid12 = request.getParameter("wid12");
		if(wid12.length()>0) widList.add(wid12);
		String wid13 = request.getParameter("wid13");
		if(wid13.length()>0) widList.add(wid13);
		String wid14 = request.getParameter("wid14");
		if(wid14.length()>0) widList.add(wid14);
		String wid15 = request.getParameter("wid15");
		if(wid15.length()>0) widList.add(wid15);

		String cid1 = request.getParameter("cid1");
		if(cid1.length()>0) cntList.add(cid1);
		String cid2 = request.getParameter("cid2");
		if(cid2.length()>0) cntList.add(cid2);
		String cid3 = request.getParameter("cid3");
		if(cid3.length()>0) cntList.add(cid3);
		String cid4 = request.getParameter("cid4");
		if(cid4.length()>0) cntList.add(cid4);
		String cid5 = request.getParameter("cid5");
		if(cid5.length()>0) cntList.add(cid5);
		String cid6 = request.getParameter("cid6");
		if(cid6.length()>0) cntList.add(cid6);
		String cid7 = request.getParameter("cid7");
		if(cid7.length()>0) cntList.add(cid7);
		String cid8 = request.getParameter("cid8");
		if(cid8.length()>0) cntList.add(cid8);
		String cid9 = request.getParameter("cid9");
		if(cid9.length()>0) cntList.add(cid9);
		String cid10 = request.getParameter("cid10");
		if(cid10.length()>0) cntList.add(cid10);
		String cid11 = request.getParameter("cid11");
		if(cid11.length()>0) cntList.add(cid11);
		String cid12 = request.getParameter("cid12");
		if(cid12.length()>0) cntList.add(cid12);
		String cid13 = request.getParameter("cid13");
		if(cid13.length()>0) cntList.add(cid13);
		String cid14 = request.getParameter("cid14");
		if(cid14.length()>0) cntList.add(cid14);
		String cid15 = request.getParameter("cid15");
		if(cid15.length()>0) cntList.add(cid15);


		ArrayList<Double>  costList = connectToDataBase(infoList,iidList,widList,cntList);
		PrintWriter out = response.getWriter();
		String cost = null;
		out.println("<html><body>");
			out.println("<center>");
			out.println("New Order");
			out.println("</center>");
			out.println("<table style="+"width: 100%"+">");
			
			out.println("<tr>");
			
			out.println("<th>");
			out.println("Warehouse");
			out.println("</th>");
			
			out.println("<td>");
			out.println(infoList.get(0));
			out.println("</td>");
			
			out.println("<th>");
			out.println("District");
			out.println("</th>");
			
			out.println("<td>");
			out.println(infoList.get(1));
			out.println("</td>");
			
			Date dNow = new Date( );
			SimpleDateFormat ft = new SimpleDateFormat ("yyyy.MM.dd");
			
			
			out.println("<th>");
			out.println("Date");
			out.println("</th>");
			
			out.println("<td>");
			out.println(ft.format(dNow).toString());
			out.println("</td>");
			
			out.println("</tr>");
			
			out.println("<tr>");
			
			out.println("<th>");
			out.println("Customer");
			out.println("</th>");
			
			out.println("<td>");
			out.println(infoList.get(2));
			out.println("</td>");
			
			out.println("<th>");
			out.println("Name");
			out.println("</th>");
			
			out.println("<td>");
			out.println("USM");
			out.println("</td>");
			
			
			out.println("<th>");
			out.println("Credict");
			out.println("</th>");
			
			out.println("<td>");
			out.println("XX");
			out.println("</td>");
			
			out.println("<th>");
			out.println("%Disc");
			out.println("</th>");
			
			out.println("<td>");
			out.println("99.99");
			out.println("</td>");
			
			out.println("</tr>");
			
			
			out.println("<tr>");
			
			out.println("<th>");
			out.println("Order Number:");
			out.println("</th>");
			
			out.println("<td>");
			out.println("9999");
			out.println("</td>");
			
			out.println("<th>");
			out.println("Number of Lines:");
			out.println("</th>");
			
			out.println("<td>");
			out.println("99");
			out.println("</td>");
			
			
			out.println("<th>");
			out.println("W_tax");
			out.println("</th>");
			
			out.println("<td>");
			out.println("99.99");
			out.println("</td>");
			
			out.println("<th>");
			out.println("D_tax");
			out.println("</th>");
			
			out.println("<td>");
			out.println("99.99");
			out.println("</td>");
			
			out.println("</tr>");
			
			
			/*out.println("<th></th>");
			out.println("11-15-2017");
			out.println("<th>District:</th>");
			out.println("<th>Date:</th>");*/
			out.println("</table>");
			
			out.println("<tablecellspacing="+"10");
			out.println("<tr>");
			
			out.println("<td>");
			out.println("Supp_W");
			out.println("</td>");
			
			out.println("<td>");
			out.println("Item_id");
			out.println("</td>");
			
			out.println("<td>");
			out.println("Item_name");
			out.println("</td>");
			
			out.println("<td>");
			out.println("Qty");
			out.println("</td>");
			
			out.println("<td>");
			out.println("Stock");
			out.println("</td>");
			
			out.println("<td>");
			out.println("B/G");
			out.println("</td>");
			
			out.println("<td>");
			out.println("Price");
			out.println("</td>");
			
			out.println("<td>");
			out.println("Amount");
			out.println("</td>");
			
			out.println("</tr>");
			
			
			out.println("<tr>");
			for(int i=0;i<costList.size();i++)
			{
				Double temp = costList.get(i);
				out.println(Double.toString(temp));
			}
			out.println("</tr>");
			out.println("</table>");
			
			
			
			out.println("Here");
			
		out.println("</body></html>");
	}

	private ArrayList<Double> connectToDataBase(ArrayList<String> infoList, ArrayList<String> iidList, ArrayList<String> widList, ArrayList<String> cntList) {
		// TODO Auto-generated method stub
		ArrayList<String> costList = new ArrayList<>();
		Database db;
		
			//Our database store
			CloudantClient store = DBClient.getInstance();
			CloudantItemStore cld = new CloudantItemStore();
			Warehouse wrh = null;
			District disinfo= null;
			Customer custinfo= null;
		try{	
			wrh = cld.getWareHouse("1001");
			try {
				Thread.sleep(1000);
				System.out.println("Sleeping ---------------");
				costList.add("Ok from 1");
			} catch(Exception ex) {
				costList.add("Not Ok from 1");
				ex.printStackTrace();
			}
		}
		catch (Exception e) {
			// TODO: handle exception
			
			costList.add("Not Ok from 2");
		}
		try{
			try {
				Thread.sleep(5000);
				System.out.println("Sleeping ---------------");
				costList.add("Ok from 2");
			} catch(InterruptedException ex) {
				ex.printStackTrace();
			}
			disinfo = cld.getDistrict(infoList.get(1));
			costList.add("Ok from 3");
		}
		catch (Exception e) {
			// TODO: handle exception
			System.out.println("Exceptoion_A2:"+ e.getMessage().toString());
			costList.add("Not Ok from 3");
		}
		try{
			try {
				Thread.sleep(5000);
				System.out.println("Sleeping ---------------");
				costList.add("Ok from 4");
			} catch(InterruptedException ex) {
				ex.printStackTrace();
			}
			custinfo = cld.getCustomer(infoList.get(2));
			costList.add("Ok from 5");
		}
		catch (Exception e) {
			// TODO: handle exception
			System.out.println("Exceptoion_A3:"+ e.getMessage().toString());
			costList.add("Not Ok from 4");
		}
		int oderCount = 0;
		Database orderdb = store.database("order", true);
		try {
			oderCount = cld.count(orderdb);
			oderCount ++;
			Thread.sleep(5000);
			System.out.println("Sleeping ---------------");
			costList.add("Ok from 6");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			costList.add("Not Ok from 5");
			e.printStackTrace();
		}
		Order odr = new Order();
		odr.setOid(Integer.toString(oderCount));
		
	
		odr.setOdid(custinfo.getCdid());
		odr.setOwid(custinfo.getCwid());
		odr.setOcid(infoList.get(2));
		Date dNow = new Date( );
		SimpleDateFormat ft = new SimpleDateFormat ("yyyy.MM.dd");
		ft.format(dNow);
		

		Transaction tran = new Transaction();
		ArrayList<Double> costListDouble = tran.select(infoList.get(0),infoList.get(1),infoList.get(2),wrh, disinfo, custinfo,  
				iidList, widList, cntList);
		
		return costListDouble;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
