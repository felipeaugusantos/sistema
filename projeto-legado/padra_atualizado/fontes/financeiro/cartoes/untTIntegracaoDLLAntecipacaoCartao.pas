unit untTIntegracaoDLLAntecipacaoCartao;

interface

uses untConsultas,Forms,EditFocus,Vcl.StdCtrls,untTypesSistema,System.SysUtils,
     untLiberacao,untFuncoesSimples;

Type
  TIntegracaoDLL = Class
  public
    Class function fIPesquisar(ASelf     : TForm;
                               edtCodigo: TCustomEdit;
                               edtDescri: TEditFocus;
                               Var chrKey: Char;
                               ACodPesquisa: String): Boolean;

    Class function PedirLiberacao(ADirAcesso: String; AMsgSenha: String; ATexto: String): Boolean;
  End;

implementation

Class function TIntegracaoDLL.fIPesquisar(ASelf : TForm;
                                          edtCodigo: TCustomEdit;
                                          edtDescri: TEditFocus;
                                          Var chrKey: Char;
                                          ACodPesquisa: String): Boolean;
  Var
    arrConsultas : TConsultasArray;
begin
  Result := False;

  If UpperCase(ACodPesquisa).Equals('ESTANTREDECARD') Then
    Result := untConsultas.fPesqEstAntecipacaoRedeCard(ASelf, edtCodigo, edtDescri, Nil, chrKey,arrConsultas,True);
end;

Class function TIntegracaoDLL.PedirLiberacao(ADirAcesso:String; AMsgSenha:String;ATexto: String): Boolean;
  Var
    objLiberacao : TLiberacao;
Begin
  Try
    objLiberacao := TLiberacao.create;


    objLiberacao.Clear;
    objLiberacao.strDirAce    := ADirAcesso;
    objLiberacao.strMsgSen    := AMsgSenha;
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.pAddTexto(ATexto);

    Result := objLiberacao.fLibera;

    If Result Then
      pGeraLogLiberacao('', '', '');
  Finally
    FreeAndNil(objLiberacao) ;
  End;

End;


end.
