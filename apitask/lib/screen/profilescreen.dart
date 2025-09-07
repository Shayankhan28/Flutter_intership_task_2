import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Profilescreen extends StatefulWidget {
  final String image, firstname, lastname, email;
  const Profilescreen({
    super.key,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.image,
  });

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading (2 seconds shimmer, then show data)
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile Details",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: const CircleAvatar(radius: 65),
                    )
                  : CircleAvatar(
                      radius: 65,
                      backgroundImage: NetworkImage(widget.image),
                    ),
              const SizedBox(height: 30),

              _isLoading
                  ? shimmereffect(h: 20, w: 140)
                  : Text(
                      "First Name: ${widget.firstname}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
              const SizedBox(height: 15),

              _isLoading
                  ? shimmereffect(h: 20, w: 140)
                  : Text(
                      "Last Name: ${widget.lastname}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
              const SizedBox(height: 15),

              _isLoading
                  ? shimmereffect(h: 20, w: 200)
                  : Text(
                      "Email: ${widget.email}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget shimmereffect({required double h, required double w}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );
}
