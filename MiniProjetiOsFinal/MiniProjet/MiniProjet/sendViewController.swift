
import UIKit

import UIKit

import MessageKit

import InputBarAccessoryView





class sendViewController: MessagesViewController {

    

    var chatService: ChatService!

    var messages: [Message] = []

    var member: Member!

    

    override func viewDidLoad() {

      super.viewDidLoad()

        

      member = Member(name: UserDefaults.standard.string(forKey: "firstname")!
, color: .random)

      messagesCollectionView.messagesDataSource = self

      messagesCollectionView.messagesLayoutDelegate = self

      messageInputBar.delegate = self

      messagesCollectionView.messagesDisplayDelegate = self

      

      chatService = ChatService(member: member, onRecievedMessage: {

        [weak self] message in

        self?.messages.append(message)

        self?.messagesCollectionView.reloadData()

        self?.messagesCollectionView.scrollToBottom(animated: true)

      })

      

      chatService.connect()

    }





  }



extension sendViewController: MessagesDataSource {

    func currentSender() -> SenderType {

        return Sender(id: member.name, displayName: member.name)



    }

    

  func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {

    return messages.count

  }

  

 

  

  func messageForItem(at indexPath: IndexPath,

                      in messagesCollectionView: MessagesCollectionView) -> MessageType {

    

    return messages[indexPath.section]

  }

  

  func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {

    return 12

  }

  

  func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {

    return NSAttributedString(

      string: message.sender.displayName,

      attributes: [.font: UIFont.systemFont(ofSize: 12)])

  }

}



extension sendViewController: MessagesLayoutDelegate {

  func heightForLocation(message: MessageType,

                         at indexPath: IndexPath,

                         with maxWidth: CGFloat,

                         in messagesCollectionView: MessagesCollectionView) -> CGFloat {

    return 0

  }

}



extension sendViewController: MessagesDisplayDelegate {

  func configureAvatarView(

    _ avatarView: AvatarView,

    for message: MessageType,

    at indexPath: IndexPath,

    in messagesCollectionView: MessagesCollectionView) {

    let message1 = ""

    let message = messages[indexPath.section]

    let color = message.member.color

    avatarView.backgroundColor = color

  }

}



extension sendViewController: InputBarAccessoryViewDelegate {

    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {

           

        chatService.sendMessage(text)

        inputBar.inputTextView.text = ""    }

}



