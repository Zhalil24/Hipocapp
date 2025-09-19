package com.hz24.architecture.my_architecture_template

import android.os.Bundle
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Uçtan uca ekran desteği
        WindowCompat.setDecorFitsSystemWindows(window, false)
    }
}
