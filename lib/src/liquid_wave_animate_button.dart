import 'package:flutter/material.dart';
import 'package:liquid_wave_animate_button/src/liquid_wave_animate_painter.dart';

/// A customizable button widget that displays a liquid fill animation.
///
/// This widget provides a button with a liquid-like filling effect. It allows you to customize:
/// - [buttonName]: The text label on the button.
/// - [width] & [height]: Size of the button.
/// - [fillLevel]: The final fill level (0.0 to 1.0) when [ariseAnimation] is true.
/// - [liquidColor]: The color of the liquid.
/// - [ariseAnimation]: If true, the liquid rising (with wave) animation is active;
///   if false, no liquid is shown.
/// - [ariseDuration]: Duration to animate the fill from 0 to [fillLevel].
/// - [borderColor] & [borderWidth]: Customize the button’s border.
/// - [textStyle]: The style of the button label.
/// - [backgroundColor]: Background color of the button.
/// - [onPressed]: A callback for when the button is tapped.
class LiquidWaveAnimateButton extends StatefulWidget {
  final String buttonName;
  final double width;
  final double height;
  final double fillLevel;
  final Color liquidColor;
  final bool ariseAnimation;
  final Duration ariseDuration;
  final Color borderColor;
  final double borderWidth;
  final TextStyle textStyle;
  final Color backgroundColor;
  final VoidCallback? onPressed;
  final double waveAmplitude;
  final double waveFrequency;

  const LiquidWaveAnimateButton({
    Key? key,
    required this.buttonName,
    this.width = 200,
    this.height = 60,
    this.fillLevel = 0.5,
    this.liquidColor = Colors.blue,
    required this.ariseAnimation,
    this.ariseDuration = const Duration(seconds: 2),
    this.borderColor =
        const Color(0x4DFFFFFF), // Default: white with 30% opacity.
    this.borderWidth = 2.0,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    this.backgroundColor = Colors.transparent,
    this.onPressed,
    this.waveAmplitude = 8.0,
    this.waveFrequency = 2.0,
  }) : super(key: key);

  @override
  _LiquidWaveAnimateButtonState createState() =>
      _LiquidWaveAnimateButtonState();
}

class _LiquidWaveAnimateButtonState extends State<LiquidWaveAnimateButton>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _fillController;
  late Animation<double> _fillAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    if (widget.ariseAnimation) {
      // Initialize the controller for the horizontal wave motion.
      _waveController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..repeat();

      // Initialize the controller for the rising fill animation.
      _fillController = AnimationController(
        vsync: this,
        duration: widget.ariseDuration,
      );
      _fillAnimation = Tween<double>(
        begin: 0.0,
        end: widget.fillLevel,
      ).animate(_fillController);
      _fillController.forward();
    } else {
      // When ariseAnimation is false, no water is shown.
      _waveController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 0),
      );
      _waveController.value = 0.0;
      _fillController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 0),
      );
      // Set fill value to 0 so no liquid is drawn.
      _fillController.value = 0.0;
      _fillAnimation = AlwaysStoppedAnimation(0.0);
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    _fillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = AnimatedBuilder(
      animation: Listenable.merge([_waveController, _fillController]),
      builder: (context, child) {
        return CustomPaint(
          painter: LiquidWaveAnimatePainter(
            waveValue: _waveController.value,
            fillValue: _fillAnimation.value,
            liquidColor: widget.liquidColor,
            borderColor: widget.borderColor,
            borderWidth: widget.borderWidth,
            backgroundColor: widget.backgroundColor,
            showLiquid: widget.ariseAnimation,
            waveAmplitude: widget.waveAmplitude,
            waveFrequency: widget.waveFrequency,
          ),
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: Center(
              child: Text(
                widget.buttonName,
                style: widget.textStyle,
              ),
            ),
          ),
        );
      },
    );

    // Wrap with a Stack to add a pressed-state overlay.
    Widget buttonWithOverlay = Stack(
      children: [
        content,
        if (_isPressed)
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.height / 2),
              color: Colors.black.withOpacity(0.2),
            ),
          ),
      ],
    );

    // Wrap with GestureDetector to handle touch feedback.
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: buttonWithOverlay,
    );
  }
}
