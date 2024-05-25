
import Trie "mo:base/Trie";
import Text "mo:base/Text";
import Nat32 "mo:base/Nat32";
import Bool "mo:base/Bool";
import Option "mo:base/Option";

actor {

  type ContactId = Nat32;
  type Contact = {
    name : Text;
    phone : Text;
    email : Text;
    isFavorite : Bool;
    isBlocked : Bool;
  };

  type ResponseContact = {
    name : Text;
    phone : Text;
    email : Text;
    isFavorite : Bool;
    isBlocked : Bool;
    id : Nat32;
  };

  private stable var next : ContactId = 0;

  private stable var contacts : Trie.Trie<ContactId, Contact> = Trie.empty();

  public func addContact(contact : Contact) : async Text {

    if ( not validatePhoneNumber(contact.phone) ) {
      return ("Phone number must be 10 digit")
    };
    let contactId = next;
    next += 1;
    contacts := Trie.replace(
      contacts,
      key(contactId),
      Nat32.equal,
      ?contact,
    ).0;
    return ("Contact Created Successfully");
  };

  public func updateContact(contactId : ContactId, contact : Contact) : async Bool {
    let result = Trie.find(contacts, key(contactId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      contacts := Trie.replace(
        contacts,
        key(contactId),
        Nat32.equal,
        ?contact,
      ).0;
    };
    return exists;
  };

  public func delete(contactId : ContactId) : async Bool {
    let result = Trie.find(contacts, key(contactId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      contacts := Trie.replace(
        contacts,
        key(contactId),
        Nat32.equal,
        null,
      ).0;
    };
    return exists;
  };
  

  private func validatePhoneNumber (phone:Text): Bool {
    if (phone.size() != 10) {
      return false;
    };
    return true;
  };

  private func key(x : ContactId) : Trie.Key<ContactId> {
    return { hash = x; key = x };
  };

};
