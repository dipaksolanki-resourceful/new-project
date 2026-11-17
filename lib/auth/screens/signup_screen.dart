import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/app_text_field.dart';
import '../bloc/auth_state.dart';

import '../bloc/auth_cubit.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool showPassword = true;
  bool showConfirmPassword = true;

  String? selectedGender;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    dobController.dispose();
    super.dispose();
  }

  Future<void> selectDOB() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Select your date of birth',
    );

    if (pickedDate != null) {
      dobController.text =
          '${pickedDate.day.toString().padLeft(2, '0')}/'
          '${pickedDate.month.toString().padLeft(2, '0')}/'
          '${pickedDate.year}';
    }
  }

  String formateDate(String? date){
    if(date == null || date.isEmpty) return "N/A";
    final parsedDate = DateFormat('dd/MM/yyyy').parse(date);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }

  void signup() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (selectedGender == null) {
      AppSnackBar.error('Please select a gender');
      return;
    }

    final data = {
      "name": name,
      "email": email,
      "dateOfBirth": formateDate(dobController.text.trim()),
      "gender": selectedGender,
      "phoneNumber": phoneController.text.trim(),
      "password": password,
    };

    context.read<AuthCubit>().signup(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(backgroundColor: const Color(0xffF5F6FA), elevation: 0),
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state) {
            final loading = state.status == ApiStatus.loading;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.person_add_alt_1,
                      size: 50,
                      color: Color(0xff6254D9),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    const Text(
                      'Create an account to get started.',
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 30),

                    AppTextField(
                      label: 'Enter your full name',
                      controller: nameController,
                      leading: Icons.person_outline,
                      isHint: true,
                      heading: "Full Name",
                      validator: (v) {
                        if (v?.isEmpty ?? true) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    AppTextField(
                      isHint: true,
                      label: 'Enter your email Address',
                      controller: emailController,
                      leading: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      heading: "Email Address",
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Please enter your email address";
                        }
                        if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(v)) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 18),
                    AppTextField(
                      isHint: true,
                      label: 'Enter your DOB',
                      controller: dobController,
                      leading: Icons.calendar_month,
                      heading: "DOB",
                      readOnly: true,
                      onTap: selectDOB,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Please enter your date of birth";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    const Text("Gender"),
                    RadioGroup<String>(
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                      child: Row(
                        children: [
                          const Radio<String>(value: 'MALE'),
                          const Text('Male'),

                          const SizedBox(width: 10),

                          const Radio<String>(value: 'FEMALE'),
                          const Text('Female'),

                          const SizedBox(width: 10),

                          const Radio<String>(value: 'OTHER'),
                          const Text('Other'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    AppTextField(
                      isHint: true,
                      label: 'Enter your phone number',
                      controller: phoneController,
                      leading: Icons.call,
                      heading: "Phone Number",
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Please enter your phone number";
                        }
                        if (v.length != 10) {
                          return "Please enter a valid 10 digit phone number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),

                    AppTextField(
                      label: 'create a password',
                      isHint: true,
                      controller: passwordController,
                      leading: Icons.lock_outline,
                      isPassword: showPassword,
                      heading: "Password",
                      instruction: "Minimum 8 chars, 1 letter, 1 number",
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Please create password";
                        }
                        if (!RegExp(
                          r'^(?=.*[A-Za-z])(?=.*\d).{8,}$',
                        ).hasMatch(v)) {
                          return "Password must contain at least 8 characters, one letter\n and one number";
                        }
                        return null;
                      },
                      trailing: IconButton(
                        onPressed: () {
                          showPassword = !showPassword;
                          setState(() {});
                        },
                        icon: Icon(
                          showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 26,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    AppTextField(
                      controller: confirmPasswordController,
                      label: 'Confirm your password',
                      heading: "Confirm password",
                      isHint: true,
                      leading: Icons.lock_outline,
                      isPassword: showConfirmPassword,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Please enter confirm password";
                        }
                        if (v != passwordController.text) {
                          return "Password and confirm password must be same";
                        }
                        return null;
                      },
                      trailing: IconButton(
                        onPressed: () {
                          showConfirmPassword = !showConfirmPassword;
                          setState(() {});
                        },
                        icon: Icon(
                          showConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 26,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: loading ? null : signup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff6254D9),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: loading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text("Signup", style: TextStyle(fontSize: 17)),
                      ),
                    ),

                    const SizedBox(height: 25),


                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          GestureDetector(
                            onTap: () {
                              context.go('/login');
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Color(0xff6254D9),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),)
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {
            if(state.status ==  ApiStatus.success)
            {
              if (state.operation == AuthOperation.signup) {
                AppSnackBar.success(state.message);

                context.go("/home");
              }

            }
            if(state.status == ApiStatus.failure)
            {
              AppSnackBar.error(state.message);
            }
          },
        ),
      ),
    );
  }
}
