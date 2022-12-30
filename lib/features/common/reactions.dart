import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

typedef CreateReactions = List<ReactionDisposer> Function(BuildContext context);
typedef CreateReaction = ReactionDisposer Function(BuildContext context);

class Reactions extends StatefulWidget {
  const Reactions({Key? key, required this.create, required this.child}) : super(key: key);

  Reactions.single({
    Key? key,
    required CreateReaction create,
    required this.child,
  })  : create = _singleToMulti(create),
        super(key: key);

  static CreateReactions _singleToMulti(CreateReaction create) => (context) => [create(context)];

  final CreateReactions create;
  final Widget child;

  @override
  State<Reactions> createState() => _ReactionsState();
}

class _ReactionsState extends State<Reactions> {
  List<ReactionDisposer>? disposers;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    disposers ??= widget.create(context);
  }

  @override
  void dispose() {
    super.dispose();
    disposers?.forEach((disposer) {
      disposer.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
