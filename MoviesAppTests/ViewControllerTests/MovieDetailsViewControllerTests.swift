import XCTest

@testable import MoviesApp

class MovieDetailsViewControllerTests: XCTestCase {
    var subject: MovieDetailsViewController!
    var mockMovie: Movie!
    var fakeViewModel: FakeMovieDetailsViewModel!
    
    override func setUp() {
        let data = MovieRequestTests.mockData
        let mockResponseModel = MoviesResponseModel.movieResponseModel(for: data)
        mockMovie = mockResponseModel.movies[0]
        fakeViewModel = FakeMovieDetailsViewModel()
        
        let navigationController = UINavigationController()
        subject = MovieDetailsViewController(movie: mockMovie, viewModel: fakeViewModel)
        navigationController.setViewControllers([subject], animated: false)
    }

    override func tearDown() {
        subject = nil
    }

    func testViewDidLoad() {
        subject.viewDidLoad()
        XCTAssertEqual(subject.title, mockMovie.title)
    }
    
    func testViewWillAppear() {
        subject.viewWillAppear(true)
        XCTAssertNotNil(subject.navigationController?.navigationBar.prefersLargeTitles)
    }
    
    func testDataSource() {
        XCTAssertTrue(subject.tableView.dataSource === subject)
    }
    
    func testTableViewCellTypeIsmovieDetailsCell() {
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MovieDetailsTableViewCell
        XCTAssertNotNil(cell)
    }
    
    func testTableViewShouldHaveOneRow() {
        XCTAssertEqual(subject.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testTableViewCellDescriptionLabelTextShouldBeCorrect() {
        let data = MovieRequestTests.mockData
        let mockResponseModel = MoviesResponseModel.movieResponseModel(for: data)
        mockMovie = mockResponseModel.movies[1]
        
        subject = MovieDetailsViewController(movie: mockMovie, viewModel: fakeViewModel)
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MovieDetailsTableViewCell
        XCTAssertEqual(cell?.descriptionLabel.text, mockMovie.overview)
    }
    
    func testTableViewCellNoDescriptionTextShouldBeCorrect() {
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MovieDetailsTableViewCell
        XCTAssertEqual(cell?.descriptionLabel.text, "No Description")
    }
    
    //fix this
    func testTableViewCellButtonTappedOpensCorrectURL() {
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MovieDetailsTableViewCell
        let data = MovieRequestTests.mockData
        let mockResponseModel = MoviesResponseModel.movieResponseModel(for: data)
        mockMovie = mockResponseModel.movies[1]
        cell?.buttonTapped()
        XCTAssertEqual(cell?.movieDescriptionURL?.absoluteString, "https://m.imdb.com/find?q=Dilwale%20Dulhania%20Le%20Jayenge")
    }
    
    func testTableViewCellFavouritesButtonTapped() {
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MovieDetailsTableViewCell
        cell?.favouriteButton.sendActions(for: .touchUpInside)
        XCTAssertNotNil(cell?.handler)
    }
    
    func testTableViewCellFavouritesButtonTapped_thenAddToFavouritesCalled() {
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MovieDetailsTableViewCell
        cell?.favouriteButton.sendActions(for: .touchUpInside)
        cell?.favouriteButton.sendActions(for: .touchUpInside)
        XCTAssertNotNil(cell?.handler)
        XCTAssertTrue(fakeViewModel.addToFavouritesCalled)
    }
}

extension MoviesResponseModel {
    static func movieResponseModel(for data: Data) -> MoviesResponseModel {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let model = try? decoder.decode(MoviesResponseModel.self, from: data)
        return model!
    }
}
