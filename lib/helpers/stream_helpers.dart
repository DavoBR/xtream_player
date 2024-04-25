String translateTrackLanguage(String language) {
  switch (language) {
    case 'spa':
      return 'Spanish';
    case 'eng':
      return 'English';
    default:
      return language;
  }
}