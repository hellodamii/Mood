import SwiftUI
import MessageUI

// Wrapper for MFMailComposeViewController
struct MailComposerView: UIViewControllerRepresentable {
    let recipients: [String]
    let subject: String
    let body: String
    @Environment(\..dismiss) private var dismiss

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailComposerView
        init(_ parent: MailComposerView) { self.parent = parent }
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
            parent.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients(recipients)
        vc.setSubject(subject)
        vc.setMessageBody(body, isHTML: false)
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
}

struct InviteFriendsView: View {
    @Environment(\..dismiss) private var dismiss
    @State private var emailText: String = ""
    @State private var emails: [String] = []
    @State private var showMailComposer: Bool = false
    @State private var showMailUnavailableAlert: Bool = false

    var validEmails: [String] {
        emails.filter { email in
            let regex = try? NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$", options: [.caseInsensitive])
            let range = NSRange(location: 0, length: (email as NSString).length)
            return regex?.firstMatch(in: email, options: [], range: range) != nil
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Invite friends")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .padding(.top, 20)

            Text("Enter email addresses")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.secondary)

            HStack {
                TextField("friend@example.com", text: $emailText)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                Button("Add") {
                    let trimmed = emailText.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !trimmed.isEmpty else { return }
                    emails.append(trimmed)
                    emailText = ""
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)

            if !emails.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(emails, id: \.self) { email in
                        HStack {
                            Text(email)
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                            Spacer()
                            Button("Remove") {
                                emails.removeAll { $0 == email }
                            }
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundColor(.pink)
                        }
                        Divider()
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            }

            Spacer()

            Button(action: {
                guard !validEmails.isEmpty else { return }
                if MFMailComposeViewController.canSendMail() {
                    showMailComposer = true
                } else {
                    showMailUnavailableAlert = true
                }
            }) {
                Text("Send email invites")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(validEmails.isEmpty ? Color.gray : Color.blue)
                    .clipShape(Capsule())
            }
            .disabled(validEmails.isEmpty)
        }
        .padding(20)
        .sheet(isPresented: $showMailComposer) {
            MailComposerView(
                recipients: validEmails,
                subject: "Join me on Mood",
                body: "Hey! I’m using the Mood app to track and share how I feel. I’d love to connect with you there. Download it and add me!"
            )
            .presentationDetents([.large])
        }
        .alert("Mail not configured", isPresented: $showMailUnavailableAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("No mail accounts are set up on this device. You can copy the emails into your preferred client.")
        }
    }
}

#Preview {
    InviteFriendsView()
}


