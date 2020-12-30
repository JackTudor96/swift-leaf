import Leaf
import Vapor
import Fluent
import FluentSQLiteDriver

// configures your application
public func configure(_ app: Application) throws {

	app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

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
	app.views.use(.leaf)
	let routers: [RouteCollection] = [
		FrontendRouter(),
		BlogRouter()
	]
	for router in routers {
		try router.boot(routes: app.routes)
	}
}
