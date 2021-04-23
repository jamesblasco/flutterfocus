package com.example.flutterfocus

import android.content.Context
import android.os.Bundle
import android.text.InputType
import android.widget.EditText
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        flutterEngine!!.platformViewsController
                .registry
                .registerViewFactory("text_field_error", TextFieldPlatformViewFactory())
    }
}

class TextFieldPlatformViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        context.setTheme(R.style.Theme_AppCompat_Light)
        val editText = EditText(context)
        editText.inputType = InputType.TYPE_CLASS_NUMBER // This does not work
        // editText.inputType = InputType.TYPE_CLASS_TEXT // This works
        return TextFieldPlatformView(editText)
    }
}


class TextFieldPlatformView(private val view: EditText) : PlatformView {

    override fun getView() = view
    override fun dispose() {}
}