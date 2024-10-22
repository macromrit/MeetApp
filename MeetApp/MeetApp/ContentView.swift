import SwiftUI
import PhotosUI
import Combine


struct ContentView: View {
    var body: some View {
        NavigationView { // Wrap the entire view in NavigationView
            VStack(spacing: 40) {
                Spacer()

                // App Logo or Symbol
                Image("clipart-dating") // Use the name of your image set
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .cornerRadius(10)

                // Welcome Message
                Text("Hey it's MeetApp")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)

                // Description or Tagline
                Text("Get your right companion today!")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)

                Spacer()

                // Sign In Button
                NavigationLink(destination: SignInView()) { // Use NavigationLink
                    Text("Sign In")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.pink.opacity(0.7))
                        .cornerRadius(10)
                }

                // Sign Up Button
                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.pink.opacity(0.7))
                        .frame(width: 300, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.pink.opacity(0.7), lineWidth: 2)
                        )
                }

                Spacer()
            }
            .padding()
        }
    }
}

//struct SignInView: View {
//
//    @State private var username: String = ""
//    @State private var password: String = ""
//    @State private var isSecure: Bool = true
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 40) {
//                Spacer()
//
//                // App Title
//                Text("Welcome Back")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundColor(.blue)
//                    .padding(.bottom, 40) // Increased bottom padding
//
//                // Username Field
//                TextField("Username", text: $username)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(.horizontal)
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 5)
//
//                // Password Field
//                HStack {
//                    if isSecure {
//                        SecureField("Password", text: $password)
//                            .padding()
//                            .background(Color.white)
//                            .cornerRadius(10)
//                            .shadow(radius: 5)
//                    } else {
//                        TextField("Password", text: $password)
//                            .padding()
//                            .background(Color.white)
//                            .cornerRadius(10)
//                            .shadow(radius: 5)
//                    }
//
//                    Button(action: {
//                        isSecure.toggle()
//                    }) {
//                        Image(systemName: isSecure ? "eye.slash" : "eye")
//                            .foregroundColor(.blue)
//                    }
//                }
//                .padding(.horizontal)
//                .padding(.bottom, 40) // Increased bottom padding
//
//                // Login Button
//                Button(action: {
//                    // Handle login action
//                    print("Logging in with \(username) and \(password)")
//                }) {
//                    Text("Login")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                        .shadow(radius: 5)
//                }
//                .padding(.horizontal)
//
//                Spacer()
//
//                // Navigation to Sign Up
//                HStack {
//                    Text("Don't have an account?")
//                        .font(.footnote)
//                    NavigationLink(destination: SignUpView()) {
//                        Text("Sign Up")
//                            .font(.footnote)
//                            .fontWeight(.bold)
//                            .foregroundColor(.blue)
//                    }
//                }
//                .padding(.top, 20)
//
//            }
//            .padding(.top, 50) // Added top padding for better alignment
//            .padding(.horizontal) // Added horizontal padding around the entire VStack
//            .background(Color(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
//            .navigationTitle("Login")
//        }
//    }
//}



struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isShowingPassword = false
    @State private var rememberMe = false
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.6), Color.purple.opacity(0.4)]),
                          startPoint: .topLeading,
                          endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    // App logo
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.white)
                        .padding(.top, 60)
                    
                    Text("Welcome Back")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                    
                    // Login form
                    VStack(spacing: 20) {
                        // Email field
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedTextFieldStyle())
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                        
                        // Password field
                        HStack {
                            if isShowingPassword {
                                TextField("Password", text: $password)
                            } else {
                                SecureField("Password", text: $password)
                            }
                            
                            Button(action: {
                                isShowingPassword.toggle()
                            }) {
                                Image(systemName: isShowingPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        .textFieldStyle(RoundedTextFieldStyle())
                        
                        // Remember me toggle
                        Toggle("Remember me", isOn: $rememberMe)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        // Login button
                        Button(action: {
                            handleLogin()
                        }) {
                            Text("Log In")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.pink)
                                .cornerRadius(25)
                        }
                        
                        // Forgot password
                        Button("Forgot Password?") {
                            // Handle forgot password
                        }
                        .foregroundColor(.white)
                        
                        // Social login options
                        HStack(spacing: 20) {
                            SocialLoginButton(image: "apple.logo", action: {})
                            SocialLoginButton(image: "g.circle.fill", action: {})
                            SocialLoginButton(image: "f.circle.fill", action: {})
                        }
                        
                        // Sign up prompt
                        HStack {
                            Text("Don't have an account?")
                                .foregroundColor(.white)
                            Button("Sign Up") {
                                // Handle sign up navigation
                            }
                            .foregroundColor(.pink)
                            .fontWeight(.bold)
                        }
                    }
                    .padding(.horizontal, 30)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Login Error"),
                message: Text("Please check your credentials and try again."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func handleLogin() {
        // Add your login logic here
        if email.isEmpty || password.isEmpty {
            showAlert = true
            return
        }
        // Implement actual login functionality
    }
}

// Custom text field style
struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.white)
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

// Social login button component
struct SocialLoginButton: View {
    let image: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: image)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.1))
                .clipShape(Circle())
        }
    }
}















// ++++++++++++++++++++++++++++++++++++++++++++

struct SignUpView: View {
    // MARK: - Properties
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var gender: String = ""
    @State private var bio: String = ""
    @State private var partnerPreferences: String = ""
    @State private var cuisinePreferences: String = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented: Bool = false
    @State private var imagePickerItem: PhotosPickerItem? = nil
    
    // MARK: - Constants
    private let gradientColors = [Color.pink.opacity(0.6), Color.purple.opacity(0.4)]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient matching login page
                LinearGradient(gradient: Gradient(colors: gradientColors),
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Profile Photo Section
                        profilePhotoSection
                            .padding(.top, 20)
                        
                        // Form Sections
                        Group {
                            personalInfoSection()
                            preferencesSection()
                            bioSection()
                            submitButton
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 30)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Create Profile")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    // MARK: - View Components
    private var profilePhotoSection: some View {
        Button(action: { isImagePickerPresented.toggle() }) {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .shadow(radius: 5)
            } else {
                VStack {
                    Image(systemName: "person.crop.circle.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                    Text("Add Profile Picture")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .frame(width: 150, height: 150)
                .background(Color.black.opacity(0.1))
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 3))
            }
        }
        .photosPicker(isPresented: $isImagePickerPresented, selection: $imagePickerItem)
        .onChange(of: imagePickerItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                }
            }
        }
    }
    
    private func personalInfoSection() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Personal Information")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            CustomTextField(title: "Name", text: $name, placeholder: "Enter your name")
            
            CustomTextField(title: "Age", text: $age, placeholder: "Enter your age")
                .keyboardType(.numberPad)
                .onReceive(Just(age)) { newValue in
                    age = newValue.filter { "0123456789".contains($0) }
                }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Gender").foregroundColor(.white)
                Picker("Select your gender", selection: $gender) {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                    Text("Other").tag("Other")
                }
                .pickerStyle(SegmentedPickerStyle())
                .background(Color.white.opacity(0.9))
                .cornerRadius(25)
            }
        }
    }
    
    private func preferencesSection() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Preferences")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            CustomTextField(title: "Partner Preferences",
                          text: $partnerPreferences,
                          placeholder: "What are you looking for in a partner?")
            
            CustomTextField(title: "Cuisine Preferences",
                          text: $cuisinePreferences,
                          placeholder: "What foods do you enjoy?")
        }
    }
    
    private func bioSection() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("About You")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Bio").foregroundColor(.white)
                TextEditor(text: $bio)
                    .frame(height: 120)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white, lineWidth: 1)
                    )
            }
        }
    }
    
    
    private var submitButton: some View {
        // Button(action: handleSubmit)
        NavigationLink(destination: RecommendationsView()) {
            Text("Create Profile")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.pink)
                .cornerRadius(25)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
        }
        .padding(.top, 20)
    }
    
    // MARK: - Helper Functions
    private func handleSubmit() {
        // Handle form submission
        print("Profile creation submitted")
    }
}

// MARK: - Supporting Views
struct CustomTextField: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundColor(.white)
            
            TextField(placeholder, text: $text)
                .padding()
                .background(Color.white)
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 1)
                )
        }
    }
}




// +++++++++++++++++++++++++++++++++++++++++++++++++


struct UserProfile: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let location: String
    let bio: String
    let interests: [String]
    let cuisinePreferences: [String]
    let images: [String] // In real app, these would be URLs or Image assets
    let matchPercentage: Int
    let distance: Double
}

struct RecommendationsView: View {
    // MARK: - Properties
    @State private var currentIndex: Int = 0
    @State private var showingProfile = false
    @State private var selectedProfile: UserProfile?
    @State private var offset: CGSize = .zero
    @State private var showingFilters = false
    
    // Sample data
    private let recommendations: [UserProfile] = [
        UserProfile(name: "Sarah", age: 28, location: "New York, NY",
                   bio: "Coffee enthusiast and adventure seeker. Love trying new restaurants and traveling.",
                   interests: ["Travel", "Food", "Hiking", "Photography"],
                   cuisinePreferences: ["Italian", "Japanese", "Thai"],
                   images: ["clipart-dating", "clipart-dating"], matchPercentage: 92, distance: 2.5),
        UserProfile(name: "Emma", age: 26, location: "Brooklyn, NY",
                   bio: "Art curator who loves indie music and weekend gallery visits.",
                   interests: ["Art", "Music", "Museums", "Yoga"],
                   cuisinePreferences: ["Mediterranean", "Vegan", "French"],
                   images: ["clipart-dating", "clipart-dating"], matchPercentage: 88, distance: 3.8)
        // Add more sample profiles as needed
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.6), Color.purple.opacity(0.4)]),
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    // Top stats bar
                    statsBar
                        .padding(.horizontal)
                        .padding(.top)
                    
                    // Card Stack
                    ZStack {
                        ForEach(recommendations.indices.reversed(), id: \.self) { index in
                            if index >= currentIndex && index <= currentIndex + 2 {
                                profileCard(for: recommendations[index])
                                    .offset(index == currentIndex ? offset : .zero)
                                    .rotationEffect(.degrees(Double(offset.width / 40)))
                                    .gesture(
                                        DragGesture()
                                            .onChanged { gesture in
                                                if index == currentIndex {
                                                    offset = gesture.translation
                                                }
                                            }
                                            .onEnded { _ in
                                                withAnimation {
                                                    swipeCard(width: offset.width)
                                                }
                                            }
                                    )
                            }
                        }
                    }
                    .padding(.vertical)
                    
                    // Action buttons
                    actionButtons
                        .padding(.horizontal)
                        .padding(.bottom)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Discover")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingFilters.toggle() }) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.white)
                    }
                }
            }
            .sheet(isPresented: $showingProfile) {
                if let profile = selectedProfile {
                    ProfileDetailView(profile: profile)
                }
            }
            .sheet(isPresented: $showingFilters) {
                FilterView()
            }
        }
    }
    
    // MARK: - Components
    private var statsBar: some View {
        HStack {
            StatBox(value: "28", label: "Matches")
            StatBox(value: "12", label: "Views")
            StatBox(value: "5", label: "Likes")
        }
    }
    
    private func profileCard(for profile: UserProfile) -> some View {
        VStack(spacing: 0) {
            // Profile Image
            ZStack(alignment: .bottomLeading) {
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(Color.gray.opacity(0.2))
//                    .frame(height: UIScreen.main.bounds.height * 0.6)
                Image("russian-girl")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: UIScreen.main.bounds.height * 0.6)
                                    .cornerRadius(20)
                                    .clipped()
                // Gradient overlay
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                    startPoint: .center,
                    endPoint: .bottom
                )
                .cornerRadius(20)
                
                // Profile info overlay
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("\(profile.name), \(profile.age)")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                    }
                    
                    Text(profile.location)
                        .font(.subheadline)
                    
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.pink)
                        Text("\(profile.matchPercentage)% Match")
                        
                        Image(systemName: "location.fill")
                            .foregroundColor(.blue)
                        Text(String(format: "%.1f miles", profile.distance))
                    }
                    .font(.subheadline)
                    
                    // Interest tags
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(profile.interests, id: \.self) { interest in
                                Text(interest)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(15)
                            }
                        }
                    }
                }
                .foregroundColor(.white)
                .padding()
            }
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
    
    private var actionButtons: some View {
        HStack(spacing: 20) {
            ActionButton(icon: "arrow.counterclockwise", color: .gray) {
                // Handle undo
            }
            
            ActionButton(icon: "xmark", color: .red) {
                withAnimation {
                    swipeCard(width: -500)
                }
            }
            
            ActionButton(icon: "star.fill", color: .blue) {
                // Handle super like
            }
            
            ActionButton(icon: "heart.fill", color: .green) {
                withAnimation {
                    swipeCard(width: 500)
                }
            }
            
            ActionButton(icon: "bolt.fill", color: .purple) {
                // Handle boost
            }
        }
    }
    
    // MARK: - Helper Functions
    private func swipeCard(width: CGFloat) {
        switch width {
        case _ where width > 100:
            // Right swipe - like
            currentIndex += 1
        case _ where width < -100:
            // Left swipe - pass
            currentIndex += 1
        default:
            // Reset position
            offset = .zero
        }
        
        offset = .zero
    }
}

// MARK: - Supporting Views
struct StatBox: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
            Text(label)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.2))
        .cornerRadius(15)
        .foregroundColor(.white)
    }
}

struct ActionButton: View {
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 3)
        }
    }
}

struct ProfileDetailView: View {
    let profile: UserProfile
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header with basic info
                VStack(alignment: .leading) {
                    Text("\(profile.name), \(profile.age)")
                        .font(.title)
                        .fontWeight(.bold)
                    Text(profile.location)
                        .foregroundColor(.gray)
                }
                
                // Bio
                Text(profile.bio)
                
                // Interests
                VStack(alignment: .leading) {
                    Text("Interests")
                        .font(.headline)
                    FlowLayout(items: profile.interests) { interest in
                        Text(interest)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.pink.opacity(0.1))
                            .cornerRadius(15)
                    }
                }
                
                // Cuisine preferences
                VStack(alignment: .leading) {
                    Text("Favorite Cuisines")
                        .font(.headline)
                    FlowLayout(items: profile.cuisinePreferences) { cuisine in
                        Text(cuisine)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.purple.opacity(0.1))
                            .cornerRadius(15)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

struct FlowLayout: View {
    let items: [String]
    let itemBuilder: (String) -> any View
    
    init(items: [String], @ViewBuilder itemBuilder: @escaping (String) -> any View) {
        self.items = items
        self.itemBuilder = itemBuilder
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(0..<items.count) { index in
                AnyView(itemBuilder(items[index]))
            }
        }
    }
}

struct FilterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var ageRange: ClosedRange<Double> = 18...50
    @State private var distance: Double = 25
    @State private var showVerifiedOnly = false
    
    var body: some View {
        @State var lowerBound: Double = 18
        @State var upperBound: Double = 60
        NavigationView {
            Form {
                Section(header: Text("Age Preference")) {
                    VStack {
                        Text("\(Int(ageRange.lowerBound)) - \(Int(ageRange.upperBound)) years")
                            .padding(.top)
                        Slider(value: $lowerBound, in: 18...60)
                        Slider(value: $upperBound, in: 18...60)
                    }
                }
                
                Section(header: Text("Maximum Distance")) {
                    VStack {
                        Text("\(Int(distance)) miles")
                            .padding(.top)
                        Slider(value: $distance, in: 1...100)
                    }
                }
                
                Section {
                    Toggle("Show Verified Profiles Only", isOn: $showVerifiedOnly)
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}








// +++++++++++++++++++++++++++++++++++++++++++++++++



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
