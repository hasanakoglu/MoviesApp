import XCTest

@testable import MoviesApp

class FavouritesViewControllerTests: XCTestCase {
    var subject: FavouritesViewController!
    var fakeViewModel: FakeFavouritesViewModel!

    override func setUp() {
        fakeViewModel = FakeFavouritesViewModel()
        subject = FavouritesViewController(viewModel: fakeViewModel)
    }

    override func tearDown() {
        super.tearDown()
        fakeViewModel = nil
        subject = nil
    }
    
    func testViewDidLoad() {
        subject.viewDidLoad()
        XCTAssertNotNil(subject.tableView)
        let delegate = subject.tableView.delegate
        let dataSource = subject.tableView.dataSource

        XCTAssertTrue(delegate === subject)
        XCTAssertTrue(dataSource === subject)
    }
    
    func testTableViewNumberOfRowsInSection() {
        let movies = Movie.movieStub()
        subject.viewModel.favourites.append(movies)
        subject.viewWillAppear(true)
        XCTAssertEqual(subject.tableView.numberOfSections, 1)
    }
    
    func testTableViewCellForRowAt() {
        let movies = Movie.movieStub()
        subject.viewModel.favourites.append(movies)
        subject.viewDidLoad()
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MovieImageCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.titleLabel.text, movies.title)
    }
    
    func testTableViewDidSelectRowAt() {
        let movies = Movie.movieStub()
        subject.viewModel.favourites.append(movies)
        subject.viewDidLoad()
        let cell: () = subject.tableView(subject.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
    }
    
    func testImageUrlIsCorrect() {
        let movies = Movie.movieStub()
        subject.viewModel.favourites.append(movies)
        subject.viewDidLoad()
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MovieImageCell
        XCTAssertNotNil(cell?.posterImg.loadImageFromUrl(urlString: movies.fullImageString))
    }
}
