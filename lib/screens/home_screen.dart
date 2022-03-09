import 'dart:developer';

import 'package:corlors/bloc/cubit.dart';
import 'package:corlors/bloc/states.dart';
import 'package:corlors/screens/second_screen.dart';
import 'package:corlors/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ColorsCubit cubit = ColorsCubit();
  TextEditingController firstColorController = TextEditingController();
  TextEditingController secondColorController = TextEditingController();
  TextEditingController thirdColorController = TextEditingController();
  bool _enableButton = false;
  bool _secondVisible = true;
  final key = GlobalKey<FormState>();

  void _saveData() {
    context.read<ColorsCubit>().sendDataToApi(
        firstColorController.text,
        secondColorController.text,
        thirdColorController.text,
        context.read<ColorsCubit>().redColor,
        context);
  }

  @override
  void initState() {
    context.read<ColorsCubit>().fetchData();
    super.initState();
  }

  @override
  void dispose() {
    firstColorController.dispose();
    secondColorController.dispose();
    thirdColorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Colors"),
        actions: [
          IconButton(
              onPressed: () {
                if (key.currentState!.validate()) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SecondScreen(
                            data: [
                              firstColorController.text,
                              secondColorController.text,
                              thirdColorController.text,
                              context.read<ColorsCubit>().redColor,
                            ],
                          )));
                } else {
                  showSnackBar(context, "data is not complete", 1);
                }
              },
              icon: const Icon(Icons.arrow_forward))
        ],
      ),
      body: BlocConsumer<ColorsCubit, ColorsStates>(
        listener: (BuildContext context, state) {
          if (state is LoadingState) print("in loading state");
          if (state is LoadedState) print("in loaded state");
        },
        builder: (context, state) {
          return Center(
            child: state is LoadingState
                ? const CircularProgressIndicator()
                : Form(
                    onChanged: () => setState(() {
                      _enableButton = key.currentState!.validate();
                    }),
                    key: key,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: firstColorController,
                            onChanged: (value) {
                              setState(() {
                                _secondVisible =
                                    !firstColorController.text.startsWith('a');
                              });
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "first color"),
                            validator: (query) {
                              if (query!.isEmpty) {
                                return "color can't be empty";
                              } else if (query.trim().length < 5 ||
                                  query.trim().length > 9) {
                                return "first color can't be less than 5 chars or more than 9 chars";
                              } else if (context
                                  .read<ColorsCubit>()
                                  .checkFirstColor(query.trim())) {
                                return context.read<ColorsCubit>().errorMessage;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Visibility(
                            visible: _secondVisible,
                            child: TextFormField(
                              key: const Key("secondColorKey"),
                              keyboardType: TextInputType.text,
                              controller: secondColorController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "second color"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "value can't be empty";
                                }
                                if (value.length < 3) {
                                  return "second color can't be less than 3 chars";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TypeAheadFormField(
                              textFieldConfiguration: TextFieldConfiguration(
                                  controller: thirdColorController,
                                  decoration: const InputDecoration(
                                      hintText: "third color",
                                      border: OutlineInputBorder())),
                              onSuggestionSelected: (suggestion) {
                                thirdColorController.text =
                                    suggestion.toString();
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: Text(suggestion.toString()),
                                );
                              },
                              noItemsFoundBuilder: (context) => const SizedBox(
                                    height: 100,
                                    child: Center(
                                        child: Text(
                                      "no colors",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                              validator: (query) {
                                if (query!.isEmpty) {
                                  return "third color can't be empty";
                                }
                                if (!context
                                    .read<ColorsCubit>()
                                    .checkThirdColor(query)) {
                                  return "color must be one of the showen";
                                }
                                return null;
                              },
                              suggestionsCallback:
                                  context.read<ColorsCubit>().getSuggestions),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            enabled: false,
                            initialValue: context.read<ColorsCubit>().redColor,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          state is LoadingData
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: _enableButton ? _saveData : null,
                                  child: const Text("Save Data"))
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
