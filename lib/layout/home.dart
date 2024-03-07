import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubits/note-Cubit/Notes_states.dart';
import '../cubits/note-Cubit/notes_cubit.dart';
import '../shared/components/my_app_bar.dart';
import '../shared/styles/style_constants.dart';
import 'bottom_sheet.dart';
import 'drawer.dart';
import 'floating_action_button.dart';
import 'notes_filter.dart';
import 'notes_view.dart';

class Home extends StatelessWidget {
  Home({super.key});

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NotesCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              MyAppBar(
                title: 'My notes',
                icon: Icons.line_weight_sharp,
                iconAction: () {
                  scaffoldKey.currentState!.openEndDrawer();
                },
              ),
              filterNotes(
                        filter: 'all',
                        notes: cubit.notes,
                      ).length >
                      0
                  ? NotesView(
                      notes: filterNotes(
                        filter: 'all',
                        notes: cubit.notes,
                      ),
                    )
                  : EmptyImage(),
            ],
          ),
          floatingActionButton: SquareFloatinButton(),
          endDrawer: blury(
            child: Drawer(
              child: MyDrawer(
                pinned: filterNotes(
                  filter: 'is_pinned',
                  notes: cubit.notes,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class EmptyImage extends StatelessWidget {
  const EmptyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Image(
          width: 100.w,
          image: AssetImage('assets/images/empty2.png'),
          color: const Color(0xffF7F7F7),
        ),
      ),
    );
  }
}
