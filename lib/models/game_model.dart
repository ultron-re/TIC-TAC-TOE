class GameModel {
  List<String> board;
  String currentPlayer;
  String? winner;
  bool isGameOver;
  bool isGameStarted;
  bool isComputerTurn;

  GameModel({
    List<String>? board,
    this.currentPlayer = 'X',
    this.winner,
    this.isGameOver = false,
    this.isGameStarted = false,
    this.isComputerTurn = false,
  }) : board = board ?? List.filled(9, '');

  bool makeMove(int index) {
    if (!isGameStarted || board[index].isNotEmpty || isGameOver) {
      return false;
    }
    
    board[index] = currentPlayer;
    _checkWinner();
    
    if (!isGameOver) {
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      isComputerTurn = currentPlayer == 'O';
    }
    return true;
  }

  void makeComputerMove() {
    if (!isGameStarted || isGameOver || !isComputerTurn) return;

    // Find empty cells
    List<int> emptyCells = [];
    for (int i = 0; i < 9; i++) {
      if (board[i].isEmpty) {
        emptyCells.add(i);
      }
    }

    if (emptyCells.isNotEmpty) {
      // Simple AI: First try to win, then block opponent, then random move
      int? move = _findWinningMove('O') ?? 
                  _findWinningMove('X') ?? 
                  emptyCells[DateTime.now().millisecondsSinceEpoch % emptyCells.length];
      
      if (move != null) {
        board[move] = 'O';
        _checkWinner();
        if (!isGameOver) {
          currentPlayer = 'X';
          isComputerTurn = false;
        }
      }
    }
  }

  int? _findWinningMove(String player) {
    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (board[i] == player && board[i + 1] == player && board[i + 2].isEmpty) return i + 2;
      if (board[i] == player && board[i + 2] == player && board[i + 1].isEmpty) return i + 1;
      if (board[i + 1] == player && board[i + 2] == player && board[i].isEmpty) return i;
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[i] == player && board[i + 3] == player && board[i + 6].isEmpty) return i + 6;
      if (board[i] == player && board[i + 6] == player && board[i + 3].isEmpty) return i + 3;
      if (board[i + 3] == player && board[i + 6] == player && board[i].isEmpty) return i;
    }

    // Check diagonals
    if (board[0] == player && board[4] == player && board[8].isEmpty) return 8;
    if (board[0] == player && board[8] == player && board[4].isEmpty) return 4;
    if (board[4] == player && board[8] == player && board[0].isEmpty) return 0;
    if (board[2] == player && board[4] == player && board[6].isEmpty) return 6;
    if (board[2] == player && board[6] == player && board[4].isEmpty) return 4;
    if (board[4] == player && board[6] == player && board[2].isEmpty) return 2;

    return null;
  }

  void _checkWinner() {
    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (board[i].isNotEmpty &&
          board[i] == board[i + 1] &&
          board[i] == board[i + 2]) {
        winner = board[i];
        isGameOver = true;
        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[i].isNotEmpty &&
          board[i] == board[i + 3] &&
          board[i] == board[i + 6]) {
        winner = board[i];
        isGameOver = true;
        return;
      }
    }

    // Check diagonals
    if (board[0].isNotEmpty && board[0] == board[4] && board[0] == board[8]) {
      winner = board[0];
      isGameOver = true;
      return;
    }
    if (board[2].isNotEmpty && board[2] == board[4] && board[2] == board[6]) {
      winner = board[2];
      isGameOver = true;
      return;
    }

    // Check for draw
    if (!board.contains('')) {
      isGameOver = true;
    }
  }

  void startGame() {
    board = List.filled(9, '');
    currentPlayer = 'X';
    winner = null;
    isGameOver = false;
    isGameStarted = true;
    isComputerTurn = false;
  }

  void reset() {
    board = List.filled(9, '');
    currentPlayer = 'X';
    winner = null;
    isGameOver = false;
    isGameStarted = false;
    isComputerTurn = false;
  }
} 