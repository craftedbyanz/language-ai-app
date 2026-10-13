import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    if let visibleFrame = (self.screen ?? NSScreen.main)?.visibleFrame {
      let windowInsets = self.frame.size.height - self.contentLayoutRect.height
      let initialSize = NSSize(
        width: min(self.contentLayoutRect.width, visibleFrame.width),
        height: min(self.contentLayoutRect.height, visibleFrame.height - windowInsets)
      )
      self.setContentSize(initialSize)
      self.center()
    }

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
