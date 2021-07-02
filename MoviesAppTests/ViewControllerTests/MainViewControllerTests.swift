import XCTest
@testable import MoviesApp

class MainViewControllerTests: XCTestCase {
    var subject: MainViewController!
    var fakeViewModel: FakeMoviesViewModel!

    override func setUp() {
        fakeViewModel = FakeMoviesViewModel()
        subject = MainViewController(viewModel: fakeViewModel)
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
        XCTAssertTrue(fakeViewModel.fetchMoviesCalled)
    }
    
    func testTableViewCellForRowAt() {
        let movies = Movie.movieStub()
        subject.viewModel.listOfMovies.append(movies)
        subject.viewDidLoad()
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MovieImageCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.nameLabel.text, movies.title)
    }
    
    func testTableViewDidSelectRowAt() {
        let movies = Movie.movieStub()
        subject.viewModel.listOfMovies.append(movies)
        subject.viewDidLoad()
        let cell: () = subject.tableView(subject.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
    }
    
    func testImageUrlIsCorrect() {
        let movies = Movie.movieStub()
        subject.viewModel.listOfMovies.append(movies)
        subject.viewDidLoad()
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MovieImageCell
        XCTAssertNotNil(cell?.img.loadImageFromUrl(urlString: movies.fullImageString))
    }
}
