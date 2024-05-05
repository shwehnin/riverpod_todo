import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app/utils/utils.dart';
import 'package:todo_app/app/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/app/widgets/circle_container.dart';

class SelectCategory extends ConsumerWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = TaskCategories.values.toList();
    final selectedCategory = ref.watch(categoryProvider);
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Text(
            "Category",
            style: context.textTheme.titleLarge,
          ),
          const Gap(10),
          Expanded(
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return InkWell(
                    onTap: () {
                      ref.read(categoryProvider.notifier).state = category;
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: CircleContainer(
                      color: category.color.withOpacity(.3),
                      child: Icon(
                        category.icon,
                        color: category == selectedCategory
                            ? context.colorScheme.primary
                            : category.color,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Gap(8),
                itemCount: categories.length),
          )
        ],
      ),
    );
  }
}
