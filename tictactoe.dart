import 'dart:io';

void main() {
  var player1 = 'X';
  var player2 = 'O';
  var gameDashboard = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];
  dashboardDisplay(gameDashboard);
  play(gameDashboard, player1, player2);
}

// Play function
void play(List<List<String>> gameDashboard, String player1, String player2) {
  var currentPlayer = player1;
  while (!isGameOver(gameDashboard)) {
    print('player $currentPlayer select the row (0-2)');
    var row = int.parse(stdin.readLineSync()!);
    print('player $currentPlayer select the column (0-2)');
    var col = int.parse(stdin.readLineSync()!);
    if (gameDashboard[row][col] == '') {
      gameDashboard[row][col] = currentPlayer;
      dashboardDisplay(gameDashboard);
      if (isWinner(gameDashboard, currentPlayer)) {
        print('Player $currentPlayer wins!');
        break;
      }
      currentPlayer = (currentPlayer == player1) ? player2 : player1;
    } else {
      print('This cell is already taken. Try again!');
    }
  }
  if (!isWinner(gameDashboard, player1) && !isWinner(gameDashboard, player2)) {
    print('Game over. It\'s a draw!');
  }
}

// Dashboard display
void dashboardDisplay(List<List<String>> gameDashboard) {
  for (var i = 0; i < gameDashboard.length; i++) {
    print(gameDashboard[i].join(' | '));
    if (i < gameDashboard.length - 1) {
      print('---------');
    }
  }
}

// Check for winner function
bool isWinner(List<List<String>> gameDashboard, String player) {
  for (var i = 0; i < 3; i++) {
    if (gameDashboard[i][0] == player && gameDashboard[i][1] == player && gameDashboard[i][2] == player) {
      return true; // Horizontal win
    }
    if (gameDashboard[0][i] == player && gameDashboard[1][i] == player && gameDashboard[2][i] == player) {
      return true; // Vertical win
    }
  }
  if (gameDashboard[0][0] == player && gameDashboard[1][1] == player && gameDashboard[2][2] == player) {
    return true; // Diagonal win (top-left to bottom-right)
  }
  if (gameDashboard[0][2] == player && gameDashboard[1][1] == player && gameDashboard[2][0] == player) {
    return true; // Diagonal win (top-right to bottom-left)
  }
  return false;
}

// Check for game over function
bool isGameOver(List<List<String>> gameDashboard) {
  for (var row in gameDashboard) {
    for (var cell in row) {
      if (cell == '') {
        return false;
      }
    }
  }
  return true;
}
