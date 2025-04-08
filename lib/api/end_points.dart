class EndPoints {

  // Endpoints:
  static const login = "/auth/login";
  static const logout = "/Auth/Logout";
  static const refreshToken = "/auth/refresh";
  static const updateUserNID = "/Notification/UpdateUesrNID";
  static const removeUserNID = "/Notification/RemoveNID";
  static const register = "/Customer/Add";
  static const resetPassword = "/Customer/ResetPassword";
  static const sendOTP = "request";
  static const verifyOTP = "verify";
  static const registerOTP = "register";


  static const getBanners = "/Banner/GetAll";
  static const getCategory = "/Category/GetAll";
  static const getProducts = "/Item/GetAll";
  static const getAllByName = "/Item/GetAllByName";

  //sections
  static const getAllSectionByType = "/Section/GetAllByType";
  static const getAllSection = "/Section/GetAll";
  static const getSectionById = "/Section/GetSectionById";

  static const checkCouponValidation = "/Coupon/CheckCoupon";
  static const createOrder = "/Order/Add";
  static const deleteDataUrl = '/Customer/finalDelete/';




}
