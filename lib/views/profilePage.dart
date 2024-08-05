import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/headerSettingsComponent.dart';
import 'package:frontend_inventary_mobile/provider/auth_bloc/auth_bloc.dart';
import 'package:frontend_inventary_mobile/provider/auth_bloc/auth_state.dart';
import 'package:frontend_inventary_mobile/provider/profile_bloc/profile_bloc.dart';
import 'package:frontend_inventary_mobile/provider/profile_bloc/profile_event.dart';
import 'package:frontend_inventary_mobile/provider/profile_bloc/profile_state.dart';
import 'package:frontend_inventary_mobile/utils/toast_utils.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _secondNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(95.0),
        child: HeaderSettingsComponent(
          title: 'Ajustes',
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              _emailController.text = state.user['email'];
              _nameController.text = state.user['name'];
              _firstNameController.text = state.user['first_name'];
              _secondNameController.text = state.user['second_name'];
              _phoneController.text = state.user['phone'];
            } else if (state is AuthError) {
              showErrorToast(state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthAuthenticated || state is AuthLoading || state is AuthInitial) {
              final user = (state is AuthAuthenticated) ? state.user : null;
              if (user != null) {
                _emailController.text = user['email'];
                _nameController.text = user['name'];
                _firstNameController.text = user['first_name'];
                _secondNameController.text = user['second_name'];
                _phoneController.text = user['phone'];
              }

              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tu perfil',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            backgroundImage: user != null && user['image'] != null
                                ? NetworkImage(user['image'])
                                : null,
                            child: user == null || user['image'] == null
                                ? const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildProfileSection(),
                    const SizedBox(height: 16),
                    _buildSecuritySection(),
                    const SizedBox(height: 26),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_passwordController.text.isNotEmpty &&
                                _passwordController.text != _confirmPasswordController.text) {
                              showErrorToast('Las contraseñas no coinciden');
                              return;
                            }
                            context.read<ProfileBloc>().add(
                                  UpdateUserRequested(
                                    _emailController.text,
                                    _nameController.text,
                                    _passwordController.text.isEmpty
                                        ? ''
                                        : _passwordController.text,
                                    _firstNameController.text,
                                    _secondNameController.text,
                                    _phoneController.text,
                                  ),
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Guardar cambios',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('No estás autenticado'));
            }
          },
        ),
      ),
      bottomNavigationBar: const FooterComponent(),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nombres',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Primer Apellido',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _firstNameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Segundo Apellido',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _secondNameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Correo',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Teléfono',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _phoneController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Seguridad',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Nueva contraseña',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(Icons.visibility_off),
              onPressed: () {
                // Toggle visibility
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Confirmar nueva contraseña',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: true,
          validator: (value) {
            if (value != _passwordController.text) {
              return 'Las contraseñas no coinciden';
            }
            return null;
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(Icons.visibility_off),
              onPressed: () {
                // Toggle visibility
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
