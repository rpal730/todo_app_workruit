import 'package:flutter/material.dart';

class CustomProcessingButton extends StatelessWidget {

	final String title;
	final bool isProcessing;
	final Color? backgroundColor;
	final Color? onProcessingBackgroundColor;
	final Color? textColor;
	final void Function()? onPressed;

	const CustomProcessingButton({
		Key? key,
		required this.title,
		required this.onPressed,
		this.isProcessing = false,
		this.backgroundColor,
		this.onProcessingBackgroundColor,
		this.textColor
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return ElevatedButton(
			onPressed: isProcessing ? () {} : onPressed,
			style: ElevatedButton.styleFrom(
				elevation: 0,
				backgroundColor: isProcessing ? (
					onProcessingBackgroundColor ?? Colors.white
				) : (
					backgroundColor ?? Colors.white
				),
				padding: const EdgeInsets.all(10),
				minimumSize: const Size.fromHeight(50),
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(10)
				)
			),
			child: isProcessing ? const CircularProgressIndicator(
			) : Text(
				title,
				style: TextStyle(
					color: textColor ?? Colors.black,
					fontSize: 15,
					fontWeight: FontWeight.w700
				),
			)
		);
	}
}