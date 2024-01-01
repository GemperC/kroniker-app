import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthBloc(this._firebaseAuth) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      emit(AuthAuthenticated(currentUser));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) {
    emit(AuthAuthenticated(_firebaseAuth.currentUser!));
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    await _firebaseAuth.signOut();
    emit(AuthUnauthenticated());
  }
}
