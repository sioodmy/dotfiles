_: ''
  # Function to compile and run a single .cpp file
  function compile_and_run_file() {
      filename="$1"
      basename="''${filename%.*}"

      echo "Compiling $filename..."
      g++ -o "$basename" "$filename"

      if [ $? -eq 0 ]; then
          echo "Running $basename..."
          "./$basename"
      else
          echo "Compilation failed."
      fi
  }

  # Function to prompt user to choose a .cpp file using skim or fzf
  function choose_cpp_file() {
      directory="$1"

      if command -v skim >/dev/null 2>&1; then
          file=$(find "$directory" -maxdepth 1 -type f -name "*.cpp" | skim --ansi --query "")
      elif command -v fzf >/dev/null 2>&1; then
          file=$(find "$directory" -maxdepth 1 -type f -name "*.cpp" | fzf)
      else
          echo "Error: skim or fzf is required for file selection."
          exit 1
      fi

      if [ -n "$file" ]; then
          compile_and_run_file "$file"
      else
          echo "No .cpp file selected."
      fi
  }

  # Function to prompt user to choose a .cpp file recursively using skim or fzf
  function choose_cpp_file_recursive() {
      directory="$1"

      if command -v skim >/dev/null 2>&1; then
          file=$(find "$directory" -type f -name "*.cpp" | sk --ansi --query "")
      elif command -v fzf >/dev/null 2>&1; then
          file=$(find "$directory" -type f -name "*.cpp" | fzf)
      else
          echo "Error: skim or fzf is required for file selection."
          exit 1
      fi

      if [ -n "$file" ]; then
          compile_and_run_file "$file"
      else
          echo "No .cpp file selected."
      fi
  }

  # Help menu
  function display_help() {
      echo "Usage: $0 [options] <file/directory>"
      echo "Options:"
      echo "  --recursive    Look for .cpp files recursively"
      echo "  --help         Display this help menu"
      echo
      echo "Examples:"
      echo "  $0 ~/Dev/test.cpp"
      echo "  $0 ~/Dev"
      echo "  $0 ~/Dev --recursive"
  }

  # Parse command line arguments
  recursive=false
  directory=""

  # Check if --help is passed
  if [[ "$1" == "--help" ]]; then
      display_help
      exit 0
  fi

  while [[ $# -gt 0 ]]; do
      case "$1" in
          --recursive)
              recursive=true
              shift
              ;;
          *)
              directory="$1"
              shift
              ;;
      esac
  done

  # Check if directory is provided
  if [ -z "$directory" ]; then
      echo "Error: No directory specified."
      display_help
      exit 1
  fi

  # Check if directory exists
  if [ ! -d "$directory" ]; then
      echo "Error: Directory does not exist."
      display_help
      exit 1
  fi

  # Compile and run or display help menu
  if [ -f "$directory" ]; then
      compile_and_run_file "$directory"
  elif [ "$recursive" = true ]; then
      choose_cpp_file_recursive "$directory"
  else
      choose_cpp_file "$directory"
  fi
''
