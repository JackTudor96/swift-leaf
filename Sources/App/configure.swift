import Leaf
import Vapor
import Fluent
import FluentSQLiteDriver

// configures your application
public func configure(_ app: Application) throws {

	app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
	app.sessions.use(.fluent)
	app.migrations.add(SessionRecord.migration)
	app.middleware.use(app.sessions.middleware)
	app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
	app.middleware.use(ExtendPathMiddleware())
	let detected = LeafEngine.rootDirectory ?? app.directory.viewsDirectory
	LeafEngine.rootDirectory = detected
	LeafEngine.sources = .singleSource(NIOLeafFiles(fileio: app.fileio,
													limits: .default,
													sandboxDirectory: detected,
													viewDirectory: detected,
													defaultExtension: "html"))
	if !app.environment.isRelease {
		LeafRenderer.Option.caching = .bypass
	}
	let defaultSource = NIOLeafFiles(fileio: app.fileio,
										limits: .default,
										sandboxDirectory: detected,
										viewDirectory: detected,
										defaultExtension: "html")

	let modulesSource = ModuleViewsLeafSource(rootDirectory: app.directory.workingDirectory,
											  modulesLocation: "Sources/App/Modules",
											  viewsFolderName: "Views",
											  fileExtension: "html",
											  fileio: app.fileio)

	let multipleSources = LeafSources()
	try multipleSources.register(using: defaultSource)
	try multipleSources.register(source: "modules", using: modulesSource)

	LeafEngine.sources = multipleSources
	app.views.use(.leaf)

	let modules: [Module] = [
		UserModule(),
		FrontendModule(),
		BlogModule(),
	]
	for module in modules {
		try module.configure(app)
	}

	try app.autoMigrate().wait()
}
