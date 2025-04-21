import 'package:flutter/material.dart';
import '../models/game_model.dart';

class GameBoard extends StatelessWidget {
  final GameModel game;
  final Function(int) onCellTap;

  const GameBoard({
    Key? key,
    required this.game,
    required this.onCellTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onCellTap(index),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  game.board[index],
                  key: ValueKey(game.board[index]),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: game.board[index] == 'X' ? Colors.white : Colors.white,
                    shadows: [
                      Shadow(
                        color: game.board[index] == 'X' 
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
} 