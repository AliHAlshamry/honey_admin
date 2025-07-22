// Helper method to check if cancel option should be shown
bool shouldShowCancelOption(String status) {
  const cancelableStatuses = [
    'NEW',
    'PREPARING',
    'READY',
    'SUSPENDED'
  ];

  return cancelableStatuses.contains(status);
}