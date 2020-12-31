// swift-tools-version:5.3
import PackageDescription

let package = Package(
	name: "leaf-project",
	platforms: [
		.macOS(.v10_15)
	],
	dependencies: [
		// 💧 A server-side Swift web framework.
		.package(url: "https://github.com/vapor/vapor.git", from: "4.30.0"),
		.package(url: "https://github.com/vapor/leaf", .exact("4.0.0-tau.1")),
		.package(url: "https://github.com/vapor/leaf-kit", .exact("1.0.0-tau.1.1")),
		.package(url: "https://github.com/vapor/fluent", from: "4.0.0"),
		.package(url: "https://github.com/vapor/fluent-sqlite-driver", from: "4.0.0"),
		.package(url: "https://github.com/lukaskubanek/LoremSwiftum", from: "2.2.1")
	],
	targets: [
		.target(name: "App", dependencies: [
			.product(name: "Vapor", package: "vapor"),
			.product(name: "Fluent", package: "fluent"),
			.product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
			.product(name: "Leaf", package: "leaf"),
			.product(name: "LoremSwiftum", package: "LoremSwiftum")
		],
		exclude: [
					//"*.html", "*.leaf"
					"Modules/Blog/Views",
					"Modules/Frontend/Views",
					"Modules/User/Views",
				]),
		.target(name: "Run", dependencies: ["App"]),
		.testTarget(name: "AppTests", dependencies: [
			.target(name: "App"),
			.product(name: "XCTVapor", package: "vapor"),
		])
	]
)
