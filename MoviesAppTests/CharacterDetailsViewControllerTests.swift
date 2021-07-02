import XCTest

@testable import Marvel_App

class CharacterDetailsViewControllerTests: XCTestCase {
    var subject: CharacterDetailsViewController!
    var mockCharacter: MarvelCharacter!
    var fakeViewModel: FakeCharacterDetailsViewModel!
    
    override func setUp() {
        let data = CharacterRequestTests.mockData
        let mockResponseModel = CharacterResponseModel.characterReponseModel(for: data)
        mockCharacter = mockResponseModel.data.characters[0]
        fakeViewModel = FakeCharacterDetailsViewModel()
        
        let navigationController = UINavigationController()
        subject = CharacterDetailsViewController(character: mockCharacter, viewModel: fakeViewModel)
        navigationController.setViewControllers([subject], animated: false)
    }

    override func tearDown() {
        subject = nil
    }

    func testViewDidLoad() {
        subject.viewDidLoad()
        XCTAssertEqual(subject.title, mockCharacter.name)
    }
    
    func testViewWillAppear() {
        subject.viewWillAppear(true)
        XCTAssertNotNil(subject.navigationController?.navigationBar.prefersLargeTitles)
    }
    
    func testDataSource() {
        XCTAssertTrue(subject.tableView.dataSource === subject)
    }
    
    func testTableViewCellTypeIsCharacterDetailsCell() {
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CharacterDetailsTableViewCell
        XCTAssertNotNil(cell)
    }
    
    func testTableViewShouldHaveOneRow() {
        XCTAssertEqual(subject.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testTableViewCellDescriptionLabelTextShouldBeCorrect() {
        let data = CharacterRequestTests.mockData
        let mockResponseModel = CharacterResponseModel.characterReponseModel(for: data)
        mockCharacter = mockResponseModel.data.characters[1]
        
        subject = CharacterDetailsViewController(character: mockCharacter, viewModel: fakeViewModel)
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CharacterDetailsTableViewCell
        XCTAssertEqual(cell?.descriptionLabel.text, mockCharacter.description)
    }
    
    func testTableViewCellNoDescriptionTextShouldBeCorrect() {
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CharacterDetailsTableViewCell
        XCTAssertEqual(cell?.descriptionLabel.text, "No Description")
    }
    
    func testTableViewCellButtonTappedOpensCorrectURL() {
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CharacterDetailsTableViewCell
        let data = CharacterRequestTests.mockData
        let mockResponseModel = CharacterResponseModel.characterReponseModel(for: data)
        mockCharacter = mockResponseModel.data.characters[1]
        cell?.buttonTapped()
        XCTAssertEqual(mockCharacter.websiteURL?.absoluteString, "http://marvel.com/comics/characters/1009610/spider-man?utm_campaign=apiRef&utm_source=ff3d4847092294acc724123682af904b")
    }
    
    func testTableViewCellFavouritesButtonTapped() {
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CharacterDetailsTableViewCell
        cell?.favouriteButton.sendActions(for: .touchUpInside)
        XCTAssertNotNil(cell?.handler)
    }
    
    func testTableViewCellFavouritesButtonTapped_thenAddToFavouritesCalled() {
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CharacterDetailsTableViewCell
        cell?.favouriteButton.sendActions(for: .touchUpInside)
        cell?.favouriteButton.sendActions(for: .touchUpInside)
        XCTAssertNotNil(cell?.handler)
        XCTAssertTrue(fakeViewModel.addToFavouritesCalled)
    }
}

extension CharacterResponseModel {
    static func characterReponseModel(for data: Data) -> CharacterResponseModel {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let model = try? decoder.decode(CharacterResponseModel.self, from: data)
        return model!
    }
}
