<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pharmacy Analytics</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="{{ asset('css/app.css') }}">
    <style>
        body {
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
            background-color: #fffdfd;
            color: rgb(125, 15, 165);
            font-family: Arial, sans-serif;
            font-size-adjust: inherit;
        }
        .container {
            display: flex;
            width: 100%;
            position: relative; /* Added to support absolute positioning of buttons */
        }
        .left {
            width: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            text-align: center;
            padding: 20px;
        }
        .right {
            width: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #fffdfd;
        }
        .illustration {
            width: 80%;
            height: auto;
        }
        .btn {
            background-color: #328bea;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin-left: 10px; /* Space between buttons */
        }
        .btn:hover {
            background-color: #021989;
        }
        .top-right-buttons {
            position: absolute;
            top: 20px;
            right: 20px;
            display: flex;
            gap: 10px; /* Consistent spacing between buttons */
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="left">
            <h1>Welcome to Pharmacy Analytics</h1>
            <p>Explore pharmaceutical insights and analytics with our advanced system.</p>
        </div>
        <div class="right">
            <img src="{{ asset('images/capsule.jpeg') }}" alt="Capsule and Tablet Illustration" class="illustration">
        </div>
        <!-- Buttons moved to top-right -->
        <div class="top-right-buttons">
            <a href="{{ url('/register') }}" class="btn">Register</a>
            <a href="{{ url('/login') }}" class="btn">Log In</a>
        </div>
    </div>
</body>
</html>