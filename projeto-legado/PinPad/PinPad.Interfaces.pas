unit PinPad.Interfaces;

interface
  type
    TPinPadCitelFabricantes = (ppcfGertec, ppcfScope) ;
    TPinPadCitelDocumentos = (ppcdCpf, ppcdCnpj) ;

    IPinPadCitel = interface
      ['{74F987A5-D3D2-4E5A-9E92-862833FFDEA2}']
      procedure pAbrirPorta ;
      procedure pFecharPorta(const AstrMensagem: AnsiString) ;
      function  fObtemDadoPinPadDireto(const ATipoDoc: TPinPadCitelDocumentos): String ;
      procedure pAbortarUltimoComando ;
      procedure pEnviarQrCode(const AstrTextoQrCode, AstrTituloInformativo: String) ;
      procedure pLimpaQrCode(const AstrMensagem: AnsiString = '') ;
      function fMsgErroAcesso: String ;
    end ;

    IPinPadCitelFactory = interface
      ['{F0FD878B-5C20-4700-A5B1-521B92EDCF9D}']
      function fAcessa(const AstrPorta: String; const AFabricante: TPinPadCitelFabricantes; const AstrPath: String): IPinPadCitel ;
    end ;

  const
    ArrayDllAcessoPinPad: array[TPinPadCitelFabricantes] of string = ('Gertec', 'Scope') ;

implementation

end.
