import XCTest

@testable import Marvel_App

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
        let characters = MarvelCharacter.characterStub()
        subject.viewModel.favourites.append(characters)
        subject.viewWillAppear(true)
        XCTAssertEqual(subject.tableView.numberOfSections, 1)
    }
    
    func testTableViewCellForRowAt() {
        let characters = MarvelCharacter.characterStub()
        subject.viewModel.favourites.append(characters)
        subject.viewDidLoad()
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CharacterImageCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.nameLabel.text, characters.name)
    }
    
    func testTableViewDidSelectRowAt() {
        let characters = MarvelCharacter.characterStub()
        subject.viewModel.favourites.append(characters)
        subject.viewDidLoad()
        let cell: () = subject.tableView(subject.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
    }
    
    func testImageUrlIsCorrect() {
        let characters = MarvelCharacter.characterStub()
        subject.viewModel.favourites.append(characters)
        subject.viewDidLoad()
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CharacterImageCell
        XCTAssertNotNil(cell?.img.loadImageFromUrl(urlString: characters.imageURL!.absoluteString))
    }
}
