

import Trie "mo:base/Trie";
import Text "mo:base/Text";
import Nat32 "mo:base/Nat32";
import Bool "mo:base/Bool";
import Option "mo:base/Option";

actor {

  type OgrId = Nat32;
  type Ogr = {
    name : Text;
    surname : Text;
    sinif : Text;
    isGecti : Bool;
    id : Nat32;
  };

  type ResponseOgr = {
    name : Text;
    surname : Text;
    sinif : Text;
    isGecti : Bool;
    id : Nat32;
  };

  private stable var next : OgrId = 0;
  private stable var ogrs : Trie.Trie<OgrId, Ogr> = Trie.empty();

  public func addOgr(ogr : Ogr) : async Text {
    let ogrId = next;
    next += 1;
    ogrs := Trie.replace(
      ogrs,
      key(ogrId),
      Nat32.equal,
      ?ogr,
    ).0;
    return ("Ogrenci Eklendi");
  };

  public func updateOgr(OgrId : OgrId, Ogr : Ogr) : async Bool {
    let result = Trie.find(ogrs, key(OgrId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      ogrs := Trie.replace(
        ogrs,
        key(OgrId),
        Nat32.equal,
        ?Ogr,
      ).0;
    };
    return exists;
  };

  public func delete(OgrId : OgrId) : async Bool {
    let result = Trie.find(ogrs, key(OgrId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      ogrs := Trie.replace(
        ogrs,
        key(OgrId),
        Nat32.equal,
        null,
      ).0;
    };
    return exists;
  };

  private func key(x : OgrId) : Trie.Key<OgrId> {
    return { hash = x; key = x };
  };

  

};
