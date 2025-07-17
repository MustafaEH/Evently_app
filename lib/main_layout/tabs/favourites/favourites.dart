import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/data/dm/eventDM.dart';
import 'package:evently/data/dm/userDM.dart';
import 'package:evently/data/firebase_service/firebase_service.dart';
import 'package:evently/main_layout/tabs/home/widgets/event_component.dart';
import 'package:evently/main_layout/tabs/home/widgets/event_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final TextEditingController _searchController = TextEditingController();
  List<EventDM> _allFavoriteEvents = [];
  List<EventDM> _filteredEvents = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterEvents);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterEvents() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredEvents = _allFavoriteEvents;
      } else {
        _filteredEvents =
            _allFavoriteEvents
                .where((event) => event.title.toLowerCase().contains(query))
                .toList();
      }
    });
  }

  void _removeEventFromFavorites(String eventId) {
    setState(() {
      _allFavoriteEvents.removeWhere((event) => event.id == eventId);
      _filteredEvents.removeWhere((event) => event.id == eventId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (UserDm.currentUser == null) {
      return Center(
        child: Text(
          'Please login to see your favorites',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      );
    }

    return Column(
      children: [
        // Search section
        SafeArea(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: CustomTextFormField(
              controller: _searchController,
              hint: "Search your favorite events...",
              prefixIcon: Icons.search,
            ),
          ),
        ),
        // Events list
        StreamBuilder(
          stream: FirebaseService.getFavoriteEventsRealTime(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                ),
              );
            }

            if (snapshot.hasError) {
              return Expanded(
                child: Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              );
            }

            _allFavoriteEvents = snapshot.data ?? [];
            _filteredEvents =
                _isSearching ? _filteredEvents : _allFavoriteEvents;

            if (_allFavoriteEvents.isEmpty) {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 64.sp,
                        color: ColorsManager.grey,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No favorite events yet',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(color: ColorsManager.grey),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Tap the heart icon on events to add them to favorites',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorsManager.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            if (_filteredEvents.isEmpty && _isSearching) {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64.sp,
                        color: ColorsManager.grey,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No events found',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(color: ColorsManager.grey),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Try searching with different keywords',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorsManager.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return Expanded(
              child: ListView.builder(
                itemBuilder:
                    (context, index) => _FavoriteEventComponent(
                      event: _filteredEvents[index],
                      onRemove: _removeEventFromFavorites,
                    ),
                itemCount: _filteredEvents.length,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _FavoriteEventComponent extends StatelessWidget {
  final EventDM event;
  final Function(String) onRemove;

  const _FavoriteEventComponent({required this.event, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: REdgeInsets.symmetric(horizontal: 8, vertical: 8),
      height: 210.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(image: AssetImage(event.Category.imagePath!)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EventDate(date: event.date),
          _FavoriteEventTitle(
            title: event.title,
            eventId: event.id!,
            onRemove: onRemove,
          ),
        ],
      ),
    );
  }
}

class _FavoriteEventTitle extends StatefulWidget {
  final String title;
  final String eventId;
  final Function(String) onRemove;

  const _FavoriteEventTitle({
    required this.title,
    required this.eventId,
    required this.onRemove,
  });

  @override
  State<_FavoriteEventTitle> createState() => _FavoriteEventTitleState();
}

class _FavoriteEventTitleState extends State<_FavoriteEventTitle> {
  bool isFavorite = true; // Always true in favorites screen

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  void _checkFavoriteStatus() {
    if (UserDm.currentUser != null) {
      setState(() {
        isFavorite = UserDm.currentUser!.favouriteEventsIds.contains(
          widget.eventId,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: REdgeInsets.symmetric(vertical: 8, horizontal: 9),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _toggleFavorite();
              },
              icon: Icon(Icons.favorite, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFavorite() async {
    if (UserDm.currentUser == null) return;

    // Remove from favorites immediately
    widget.onRemove(widget.eventId);

    // Update Firestore
    await FirebaseService.removeEventFromFav(widget.eventId);
  }
}
