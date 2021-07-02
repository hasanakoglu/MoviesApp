import XCTest
@testable import MoviesApp

class MainViewControllerTests: XCTestCase {
    var subject: MainViewController!
    var fakeViewModel: FakeCharactersViewModel!

    override func setUp() {
        fakeViewModel = FakeCharactersViewModel()
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
        XCTAssertTrue(fakeViewModel.fetchCharactersCalled)
    }
    
    func testTableViewCellForRowAt() {
        let characters = MarvelCharacter.characterStub()
        subject.viewModel.listOfCharacters.append(characters)
        subject.viewDidLoad()
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CharacterImageCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.nameLabel.text, characters.name)
    }
    
    func testTableViewDidSelectRowAt() {
        let characters = MarvelCharacter.characterStub()
        subject.viewModel.listOfCharacters.append(characters)
        subject.viewDidLoad()
        let cell: () = subject.tableView(subject.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
    }
    
    func testImageUrlIsCorrect() {
        let characters = MarvelCharacter.characterStub()
        subject.viewModel.listOfCharacters.append(characters)
        subject.viewDidLoad()
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CharacterImageCell
        XCTAssertNotNil(cell?.img.loadImageFromUrl(urlString: characters.imageURL!.absoluteString))
    }
}
