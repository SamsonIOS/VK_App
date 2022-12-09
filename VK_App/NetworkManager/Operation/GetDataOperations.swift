// GetDataOperations.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire

/// Запрос в сеть
final class GetDataOperations: AsyncOperation {
    // MARK: Public Properties

    var data: Data?

    // MARK: Private Properties

    private var request: DataRequest

    // MARK: Initializers

    init(request: DataRequest) {
        self.request = request
    }

    // MARK: Public Methods
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }

    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
}
