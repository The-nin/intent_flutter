abstract final class LocaleKeys {
  static const app = _AppKeys();

  static const profile = _ProfileKeys();
  static const authentication = _AuthenticationKeys();
  static const bottomNavigation = _BottomNavigationKeys();
  static const theme = _ThemeKeys();
  static const homeScreen = _HomeScreenKeys();
  static const favoriteScreen = _FavoriteScreenKeys();
  static const common = _CommonKeys();
  static const detailScreen = _DetailScreenKeys();
  static const products = _ProductsKeys();
  static const webView = _WebViewKeys();
}

class _AppKeys {
  const _AppKeys();

  String get title => 'app.title';
}

class _ProfileKeys {
  const _ProfileKeys();

  String get profileTitle => 'profile.profileTitle';
  String get general => 'profile.general';
  String get preferences => 'profile.preferences';
  String get notification => 'profile.notification';
  String get security => 'profile.security';
  String get language => 'profile.language';
  String get legalAndPolicies => 'profile.legalAndPolicies';
  String get helpAndSupport => 'profile.helpAndSupport';
  String get logout => 'profile.logout';
  String get errorLogoutMessage => 'profile.errorLogoutMessage';
  String get errorAvatarMessage => 'profile.errorAvatarMessage';
  String get camera => 'profile.camera';
  String get gallery => 'profile.gallery';
  String get openWebView => 'profile.openWebView';
  String get theme => 'profile.theme';

  String get featureUnderDevelopment => 'profile.featureUnderDevelopment';
}

class _AuthenticationKeys {
  const _AuthenticationKeys();

  String get loginTitle => 'authentication.loginTitle';

  String get loginSubtitle => 'authentication.loginSubtitle';

  String get moveSignUpTextSpan1 => 'authentication.moveSignUpTextSpan1';

  String get moveSignUpTextSpan2 => 'authentication.moveSignUpTextSpan2';

  String get loginForgotPassword => 'authentication.loginForgotPassword';

  String get loginUsername => 'authentication.loginUsername';

  String get loginPassword => 'authentication.loginPassword';

  String get loginUsernameHint => 'authentication.loginUsernameHint';

  String get loginPasswordHint => 'authentication.loginPasswordHint';

  String get loginUsernameWarning => 'authentication.loginUsernameWarning';

  String get loginPasswordWarning => 'authentication.loginPasswordWarning';

  String get loginButton => 'authentication.loginButton';

  String get loginSuccess => 'authentication.loginSuccess';

  String get loginError => 'authentication.loginError';

  String get signUpTitle => 'authentication.signUpTitle';

  String get signUpSubtitle => 'authentication.signUpSubtitle';

  String get moveLoginTextSpan1 => 'authentication.moveLoginTextSpan1';

  String get moveLoginTextSpan2 => 'authentication.moveLoginTextSpan2';

  String get signUpUsername => 'authentication.signUpUsername';

  String get signUpPassword => 'authentication.signUpPassword';

  String get signUpConfirmPassword => 'authentication.signUpConfirmPassword';

  String get signUpUsernameHint => 'authentication.signUpUsernameHint';

  String get signUpPasswordHint => 'authentication.signUpPasswordHint';

  String get signUpUsernameWarning => 'authentication.signUpUsernameWarning';

  String get signUpPasswordWarning => 'authentication.signUpPasswordWarning';

  String get signUpConfirmPasswordHint =>
      'authentication.signUpConfirmPasswordHint';

  String get signUpConfirmPasswordWarning =>
      'authentication.signUpConfirmPasswordWarning';

  String get errorConfirmPasswordWarning =>
      'authentication.errorConfirmPasswordWarning';

  String get signUpUnavailable => 'authentication.signUpUnavailable';

  String get signUpButton => 'authentication.signUpButton';
  String get splashMessage => 'authentication.splashMessage';
}

class _BottomNavigationKeys {
  const _BottomNavigationKeys();

  String get home => 'bottomNavigation.home';
  String get order => 'bottomNavigation.order';
  String get favorite => 'bottomNavigation.favorite';
  String get profile => 'bottomNavigation.profile';
}

class _ThemeKeys {
  const _ThemeKeys();

  String get lightTheme => 'theme.lightTheme';
  String get darkTheme => 'theme.darkTheme';
  String get systemTheme => 'theme.systemTheme';
}

class _HomeScreenKeys {
  const _HomeScreenKeys();

  String get homeTitle => 'homeScreen.homeTitle';

  String get featuredProducts => 'homeScreen.featuredProducts';

  String get searchForProducts => 'homeScreen.searchForProducts';
}

class _FavoriteScreenKeys {
  const _FavoriteScreenKeys();

  String get favoriteTitle => 'favoriteScreen.favoriteTitle';

  String get errorMessage => 'favoriteScreen.errorMessage';

  String get emptyMessage => 'favoriteScreen.emptyMessage';
}

class _CommonKeys {
  const _CommonKeys();

  String get bannerOffline => 'common.bannerOffline';

  String get retry => 'common.retry';
}

class _DetailScreenKeys {
  const _DetailScreenKeys();

  String get detailTitle => 'detailScreen.detailTitle';

  String get description => 'detailScreen.description';

  String get like => 'detailScreen.like';

  String get liked => 'detailScreen.liked';
}

class _ProductsKeys {
  const _ProductsKeys();

  String get emptyMessage => 'products.emptyMessage';

  String get tryAgainButton => 'products.tryAgainButton';

  String get loadingMessage => 'products.loadingMessage';

  String get errorMessage => 'products.errorMessage';
}

class _WebViewKeys {
  const _WebViewKeys();

  String get title => 'webView.title';

  String get error => 'webView.error';

  String get errorLoadUrl => 'webView.errorLoadUrl';
}
