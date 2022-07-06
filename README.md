## Starbucks clone coding



스타벅스 앱 클론 코딩 프로젝트입니다.



### 🗓 프로젝트 기간

2022.05.09 ~ 2022.05.20



### 📷 Screenshots

<pre>
<img src="https://user-images.githubusercontent.com/92504186/177454906-4a7a1be6-b450-4fc3-a8ff-7e566e739f17.jpg" alt="SS2022-07-06AM11 25 13" width="30%;" />&nbsp;<img src="https://user-images.githubusercontent.com/92504186/177454944-e3b4f0ad-b6e8-4470-9574-e99ab8668a9d.jpg" alt="SS2022-07-06AM11 25 26" width="30%;" />&nbsp;<img src="https://user-images.githubusercontent.com/92504186/177454968-d857c7ad-62e8-4760-90fb-62bcec14c974.jpg" alt="SS2022-07-06AM11 26 44" width="30%;" />&nbsp;<img src="https://user-images.githubusercontent.com/92504186/177454980-bad6038d-d0e0-46de-9174-9be78a78f11d.jpg" alt="SS2022-07-06AM11 26 53" width="30%;" />&nbsp;
</pre>



![SS2022-07-06AM11 28 00](https://user-images.githubusercontent.com/92504186/177455258-0d0dce00-69eb-46e8-bf96-0a5f128f792d.gif)

### 🔥 Trouble Shooting

1. LoginViewController -> EventViewController 이동시, EventView의 버튼에 Action이 추가되지 않는 문제 해결

	- LoginViewController -> EventViewController 이동시 EventView의 button의 addAction 메소드를 호출하는 타이밍과,

		`EventViewController.action = self` 가 호출되는 시점에 차이가 발생해 button에 Action이 추가되지 않는 문제가 발생했습니다.

	- 이를 해결하기 위해, 기존에는 SceneDelegate/ LoginViewController에서 EventViewContrller 객체를 생성하고 SceneUseCase/ LoginUseCase로부터 EventData를 받아와(해당하는 메소드의 반환값을 받아와) EventViewController 객체에 전달해주는 흐름이었는데, 

		이를 SceneUseCase/ LoginUseCase에서 EventData를 받아오는 메소드의 completionHandler 파라미터에 들어갈 클로저에서 새로운 EventViewController 객체에 넣어주고 present하는 흐름으로 변경했습니다.

		```swift
		// 기존 코드
		// LoginViewController
		func presentNextViewController(_ type: ViewControllerType) {
		    var nextViewController: UIViewController
		
		    switch type {
		    case .EventViewController:
		        nextViewController = EventViewController()
		        usecase.getEventData { result in
		            switch result {
					case .success(let starbucksDTO):
						let eventViewController = nextViewController as? EventViewController
		                eventViewController?.setEventDTO(DTO: starbucksDTO)
		            ...
		            }
		        }
		    }
		
		    present(nextViewController, animated: true, completion: nil)
		}
		
		// 수정된 코드
		// LoginViewController
		func presentNextViewController(_ type: ViewControllerType) {
		    switch type {
		    case .EventViewController:
		        usecase.getEventData { result in
		        	switch result {
		                case .success(let starbucksDTO):
		                DispatchQueue.main.async { [weak self] in
		                    let eventViewController = EventViewController()
		                    eventViewController.setEventDTO(DTO: starbucksDTO)
							self?.present(eventViewController, animated: true, completion: nil)
		                }
		            }
		        }
		    }
		}
		```

	- 해당 방법처럼 수정하니 기존에 발생했던 문제를 해결할 수 있었습니다.

2. HomeViewController에 있는 View에 필요한 데이터를 각기 다른 API를 사용해 비동기적으로 받아오기 때문에 발생하는 문제 해결

	- HomeViewController에 필요한 데이터가 여러 API를 사용해야하여 각각 데이터를 받아온 후 한 번에 보여주기 위해 어떤 방법을 사용할지 고민했습니다.

	- DispatchGroup을 이용해 여러 Session에서 이루어지는 작업들을 Serial Queue에 넣은 후, 해당 Task들이 모두 끝나면 DispatchGroup을 종료하고, 거기서 만든 DTO를 Delegate를 이용해 전달하는 방법을 사용했습니다.

		| HomeView에 보여질 데이터들의 요청 흐름 설계                  |
		| ------------------------------------------------------------ |
		| <img width="672" alt="스크린샷 2022-05-18 오후 5 15 24" src="https://user-images.githubusercontent.com/62687919/168991409-331085a0-8dd1-4ece-98fc-ceea14bb9fbc.png"> |

		

	- 위 방법을 통해 Home 화면에 필요한 View들을 한 번에 업로드할 수 있었습니다.

	- 만약 모든 데이터들을 한 번에 View들에 업로드할 필요가 없다면, placeholder를 사용해 해당하는 데이터가 업로드 되기 전까지 보여주고, 각각 업로드가 되는 시점에 placeholder를 실제 데이터로 바꿔치기하는 방법을 사용할 수 있겠다고 생각했습니다.

3. WhatsNewCollectionCell을 등록 일자 순으로 Sorting하기 위한 방법

	- 처음에는 WhatsNewCollectionCell에 들어갈 DTO에서 이미지를 받아와 해당 DTO를 Entity로 변환해준 후, 이미지를 받아온 순서부터 CollectionView에 `insertItem` 해주도록 했습니다.

		이렇게 하면, 등록 일자 순으로 정렬이 되지 않아 이벤트가 순서없이 뒤죽박죽 업로드되는 문제가 발생했습니다.

	- WhatsNewCollectionDataSource 객체에 [WhatNewDescription?] (Entity Optional 타입의 배열) 타입의 배열을 만들어 DTO의 개수에 맞게 nil로 채워주고, Entity에는 index 타입 변수를 추가하여, 이미지에 해당하는 데이터를 받아온 Entity가 어느 Cell에 들어갈지에 대한 정보를 가지도록 했습니다.

		Service 객체에서 DTO를 받아와 이벤트 등록 일자 순으로 정렬해서 DTO 배열을 Repository 객체로 넘겨주고, Repository 객체에서는 받아온 배열의 원소들을 Entity로 가공하여 ViewController에 있는 CollectionView의 Cell을 만들어주도록 했습니다.

		그리고 각 Cell에 들어갈 이미지 데이터를 Service 객체를 통해 받아와서, 해당하는 이벤트 Entity의 index를 찾아서 넣어줄 수 있도록 했습니다.

	- 해당 방법을 이용해 이벤트 등록 일자 순으로 정렬된 Cell을 가지는 CollectionView를 만들 수 있었습니다.
