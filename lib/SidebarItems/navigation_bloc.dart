import 'package:bloc/bloc.dart';
import 'package:halfwaiteradminapp/Dashboard/Dashboard.dart';
import 'package:halfwaiteradminapp/SideNavPages/CategoryList.dart';
import 'package:halfwaiteradminapp/SideNavPages/Delivery.dart';
import 'package:halfwaiteradminapp/SideNavPages/MenuList.dart';
import 'package:halfwaiteradminapp/SideNavPages/ParentCategoryList.dart';


enum NavigationEvents {

  DashBoardClickedEvent,
  DeliveryClickedEvent,
  MenuListClickedEvent,
  CategoryClickedEvent,
  ParentCategoryClickedEvent,
//  BillPhotoClickedEvent,
//  AttendanceClickedEvent,
//  TransportationClickedEvent,
//  StockClickedEvent,
//  ExpenseClickedEvent,
//  SupplierListClickedEvent,
//  ProductListClickedEvent,
//  UnitClickedEvent,

}

abstract class NavigationStates {}


class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  final id,name,onStatus;

  NavigationBloc(this.id,this.name,this.onStatus);

  @override
  NavigationStates get initialState => Dashboard(id,name,onStatus);

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashBoardClickedEvent:
        yield Dashboard(id,name,onStatus);
        break;
      case NavigationEvents.DeliveryClickedEvent:
        yield Delivery(id,name);
        break;
      case NavigationEvents.MenuListClickedEvent:
        yield MenuList(id,name,onStatus);
        break;
      case NavigationEvents.CategoryClickedEvent:
        yield CategoryList(id,name);
        break;
      case NavigationEvents.ParentCategoryClickedEvent:
        yield ParentCategoryList(id,name);
        break;
//      case NavigationEvents.AttendanceClickedEvent:
//        yield Attendance(id,name,sitename,siteId);
//        break;
//      case NavigationEvents.TransportationClickedEvent:
//        yield TransportationCostManager(id,name,sitename,siteId);
//        break;
//      case NavigationEvents.StockClickedEvent:
//        yield Stock(id,name,sitename,siteId);
//        break;
//      case NavigationEvents.ExpenseClickedEvent:
//        yield OverheadExpense(id,name,sitename,siteId);
//        break;
//      case NavigationEvents.SupplierListClickedEvent:
//        yield SupplierList(siteId);
//        break;
//      case NavigationEvents.ProductListClickedEvent:
//        yield ProductList(siteId);
//        break;
//      case NavigationEvents.UnitClickedEvent:
//        yield UnitList();
//        break;
    }
  }
}