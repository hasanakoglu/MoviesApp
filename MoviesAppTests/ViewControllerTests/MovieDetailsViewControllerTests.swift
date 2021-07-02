import XCTest

@testable import MoviesApp

class MovieDetailsViewControllerTests: XCTestCase {
    var subject: MovieDetailsViewController!
    var mockMovie: Movie!
    var fakeViewModel: FakemovieDetailsViewModel!
    
    override func setUp() {
        let data = MovieRequestTests.mockData
        let mockResponseModel = MoviesResponseModel.movieResponseModel(for: data)
        mockMovie = mockResponseModel.movies[0]
        fakeViewModel = FakemovieDetailsViewModel()
        
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
    
    func testTableViewCellButtonTappedOpensCorrectURL() {
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MovieDetailsTableViewCell
        let data = MovieRequestTests.mockData
        let mockResponseModel = MoviesResponseModel.movieResponseModel(for: data)
        mockMovie = mockResponseModel.movies[1]
        cell?.buttonTapped()
        XCTAssertEqual(mockMovie.overview, "http://marvel.com/comics/movies/1009610/spider-man?utm_campaign=apiRef&utm_source=ff3d4847092294acc724123682af904b")
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
