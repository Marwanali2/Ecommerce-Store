import 'package:ecommerce/core/utils/colors.dart';
import 'package:ecommerce/core/widgets/custom_error_widget.dart';
import 'package:ecommerce/features/home/presentation/managers/banner_cubit/banner_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerCubit, BannerState>(
      builder: (context, state) {
        var cubit=BlocProvider.of<BannerCubit>(context);
        if (state is BannerSuccess) {
          return Column(
            children: [
              //EnjoyBar(context), // app bar
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 200,
                child: Swiper(
                  autoplay: true,
                  autoplayDelay: 3000,
                  curve: Curves.easeInOutBack,
                  viewportFraction: 0.7,
                  scale: 0.75,
                  itemCount: cubit.bannersList!.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: SizedBox(
                        height: 200,
                        width: 350,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child: Image.network(
                            '${cubit.bannersList?[index].imageUrl}',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        } else if (state is BannerFailure) {
          return Column(
            children: [
              //EnjoyBar(context), // app bar
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 200,
                child: Swiper(
                  autoplay: true,
                  autoplayDelay: 3000,
                  curve: Curves.easeInOutBack,
                  viewportFraction: 0.7,
                  scale: 0.75,
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: SizedBox(
                        height: 200,
                        width: 350,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child: const CustomErrorWidget(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              //EnjoyBar(context), // app bar
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 200,
                child: Swiper(
                  autoplay: true,
                  autoplayDelay: 3000,
                  curve: Curves.easeInOutBack,
                  viewportFraction: 0.7,
                  scale: 0.75,
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: SizedBox(
                        height: 200,
                        width: 350,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child: const Center(
                              child: CircularProgressIndicator()),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }


}
