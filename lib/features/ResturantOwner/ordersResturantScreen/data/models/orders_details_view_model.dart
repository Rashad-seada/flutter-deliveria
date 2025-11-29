import 'package:delveria/features/ResturantOwner/ordersResturantScreen/data/models/get_orders_resturant_response.dart';
import 'package:delveria/features/deliveryAgent/data/models/get_accepted_orders.dart';
import 'package:delveria/features/deliveryAgent/data/models/get_not_accepted_order_agent.dart';

class OrderDetailsViewModel {
  final bool isDeliveryAgent;
  final bool isRestaurant;
  final bool isReceived;
  final String? orderId;
  final String? agentStatus;
  final String? orderStatus;
  final String? singleStatus;

  // Customer info
  final String? customerName;
  final String? customerPhone;
  final String? customerAddress;
  final String? addressDetails;
  final String? paymentType;

  // Order data
  final ResturantOrderModel? restaurantOrderModel;
  final AgentOrder? agentOrder;
  final AcceptedOrder? acceptedOrder;

  OrderDetailsViewModel({
    required this.isDeliveryAgent,
    this.isRestaurant = false,
    required this.isReceived,
    this.orderId,
    this.agentStatus,
    this.orderStatus,
    this.singleStatus,
    this.customerName,
    this.customerPhone,
    this.customerAddress,
    this.addressDetails,
    this.paymentType,
    this.restaurantOrderModel,
    this.agentOrder,
    this.acceptedOrder,
  });

  String get formattedOrderId {
    String? id = _getOrderId();
    if (id == null) return "";
    return id.length > 6 ? id.substring(1, 6) : id;
  }

  String? _getOrderId() {
    if (isDeliveryAgent && acceptedOrder?.id.isNotEmpty == true) {
      return acceptedOrder!.id;
    }
    if (isDeliveryAgent &&
        agentOrder?.orders.isNotEmpty == true &&
        agentOrder!.orders.first.restaurantId.id.isNotEmpty) {
      return agentOrder!.orders.first.restaurantId.id;
    }
    if (restaurantOrderModel?.id?.isNotEmpty == true) {
      return restaurantOrderModel!.id;
    }
    return null;
  }

  List<dynamic> get orderItems {
    if (isDeliveryAgent) {
      if (agentOrder?.orders.isNotEmpty == true) {
        return agentOrder!.orders.first.items;
      }
      if (acceptedOrder?.orders.isNotEmpty == true) {
        return acceptedOrder!.orders.first.items;
      }
      return [];
    }
    return restaurantOrderModel?.items ?? [];
  }
}
